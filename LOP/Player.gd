extends KinematicBody2D

signal grounded_updated(is_grounded)
#movement variables
export (int) var speed = 300/4
export (int) var jump_speed = -140
export (int) var gravity = 1000/4

export (float, 0, 1.0) var friction = 0.25
export (float, 0, 1.0) var acceleration = 0.5

export (float , 0, 100) var health = 100
export (int) var knockback := 1000/4

var velocity = Vector2.ZERO
var is_jumping :bool= false
var is_wallsliding:bool = false

onready var RcRight = $PlayerRaycasts/RcRight
onready var RcLeft = $PlayerRaycasts/RcLeft
var wall_direction = 1

var can_double_jump :bool = true
var is_on_ground:bool = false

onready var CursorDirection = $cursor_direction
onready var WeaponShotParticles = $cursor_direction/WeaponShotParticles

var grappling:bool = false
var hook_point = Vector2()
var hook_point_get = false

onready var Hook = $cursor_direction/RayCast2D

var sword = preload("res://PlayerSword.tscn")


var bullet_phaser = preload("res://PlayerBullet.tscn")
var laser_gun = preload("res://PlayerLaserGun.tscn")
var bullet_laser = preload("res://PlayerBulletLaser.tscn")
var bullet_shotgun = preload("res://ShotgunBullet.tscn")
var shotgun = preload("res://PlayerShotgun.tscn")
onready var CoyoteTimer = $CoyoteTimer
onready var JumpBuffer = $JumpBuffer

var sword_red = preload("res://SwordRed.tscn")

onready var AnimSprite = $Sprite
#gui variables

onready var HealthBar = $CanvasLayer/PlayerGUI/PlayerHealthbar

var ItemIcon = preload("res://ItemIcon.tscn")
onready var ItemIcons = $CanvasLayer/PlayerGUI/ItemIcons

onready var WeaponMenu = $CanvasLayer/PlayerGUI/CenterContainer/WeaponMenu
var WeaponSlot = preload("res://WeaponSlotButton.tscn")
onready var CurrentWeaponIcon = $CanvasLayer/PlayerGUI/CurrentWeaponSprite/CurrentWeaponIcon

onready var DeathScreen = preload("res://DeathScreen.tscn")
var SavedGamePopup = preload("res://SaveGamePopup.tscn")

#sound variables
onready var SoundPlayer = $PlayerSoundPlayer
var jump_sound = preload("res://Sounds/mixkit-quick-jump-arcade-game-239.wav")
var phaser_shoot = preload("res://Sounds/mixkit-game-ball-tap-2073.wav")
var phaser_hit_wall = preload("res://Sounds/mixkit-small-hit-in-a-game-2072.wav")
var got_hit = preload("res://Sounds/mixkit-small-hit-in-a-game-2072.wav")
#shader variables

onready var AnimPlayer = $AnimationPlayer

var can_shoot:bool = true

var deadzone:float = 0.4 

var current_weapon 

var minimap_icon = "player"

var time_played

func _ready():
#	AnimPlayer.play("portal_opening")
	
	CursorDirection.player = self
	
	SaveAndLoadHandler.player = self
	GlobalPlayerInventory.player = self
	
	if GlobalRoomHandler.weapon_phaser == true:
		add_weapon("phaser")
	if GlobalRoomHandler.weapon_laser == true:
		add_weapon("laser")
	if GlobalRoomHandler.weapon_red_sword == true:
		add_weapon("red_sword")
	if GlobalRoomHandler.weapon_shotgun == true:
		add_weapon("shotgun")
	
	
	for w in WeaponMenu.get_children():
		w.player = self
	
	
	#set camera limits to room tilemap
	
	var tilemap_rect = get_parent().get_node("TileMap").get_used_rect()
	var tilemap_size = get_parent().get_node("TileMap").cell_size

	$Camera2D.limit_left = tilemap_rect.position.x * tilemap_size.x
	$Camera2D.limit_right = tilemap_rect.end.x * tilemap_size.x
	$Camera2D.limit_top = tilemap_rect.position.y * tilemap_size.y
	$Camera2D.limit_bottom = tilemap_rect.end.y * tilemap_size.y
	

func get_input():
	var dir = 0
	if Input.is_action_pressed("move_right"):
		dir += 1
		if get_global_mouse_position().x > global_position.x:
			AnimSprite.flip_h = false
		else:
			AnimSprite.flip_h = true
		if is_on_floor():
			AnimSprite.play("walk")
		else:
			AnimSprite.play("jump")
	elif Input.is_action_pressed("move_left"):
		dir -= 1
		if get_global_mouse_position().x < global_position.x:
			AnimSprite.flip_h = true
		else:
			AnimSprite.flip_h = false
		
		if is_on_floor():
			AnimSprite.play("walk")
		else:
			AnimSprite.play("jump")
	else:
		if !is_on_floor():
			AnimSprite.play("jump")
		else:
			AnimSprite.play("idle")
			AnimSprite.stop()
	
		
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
	if Input.is_action_pressed("shoot") and can_shoot == true:
		
		if current_weapon == "phaser":
			var b = bullet_phaser.instance()
			b.transform = CursorDirection.transform
			b.position = $Position2D.global_position
			b.owned = self
			SoundPlayer.stream = phaser_shoot
			SoundPlayer.play()
			get_parent().add_child(b)
			
		if current_weapon == "laser":
			var b = bullet_laser.instance()
			b.transform = CursorDirection.transform
			b.position = $Position2D.global_position
			$ShootTimer.wait_time = 0.25
			
			SoundPlayer.stream = phaser_shoot
			SoundPlayer.play()
			get_parent().add_child(b)
		
		if current_weapon == "shotgun":
			var b = bullet_shotgun.instance()
			b.transform = CursorDirection.transform
			b.position = $Position2D.global_position
			$ShootTimer.wait_time = 1
			
			SoundPlayer.stream = phaser_shoot
			SoundPlayer.play()
			get_parent().add_child(b)
		
		can_shoot = false
		WeaponShotParticles.emitting = true
		$ShootTimer.start()
		
	if Input.is_action_pressed("melee_hit") and can_shoot == true:
		melee_hit(dir)
		can_shoot = false
		$ShootTimer.start()
		
	
func _physics_process(delta):
	
	if speed == 0:
		AnimSprite.play("default")	#detect controller movement to change input mode
	if velocity.y >= gravity:
			velocity.y = gravity
	
	if is_wallsliding == false:
		var was_grounded = is_on_floor()
		get_input()
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)
		if !is_on_floor() and was_grounded and !is_jumping:
			CoyoteTimer.start()
	if is_on_floor() and !JumpBuffer.is_stopped():
		JumpBuffer.stop()
		jump()
	if Input.is_action_just_pressed("jump"):
		jump()
	if velocity.y >= 0:
		is_jumping = false
	if is_on_floor():
		is_on_ground = true
		can_double_jump = true
	update_wall_direction()
		
	#handle gui stuff
	if current_weapon == "laser":
		CurrentWeaponIcon.current_icon = CurrentWeaponIcon.PlayerLaserIcon
		for w in get_tree().get_nodes_in_group("player_weapon"):
			w.queue_free()
		var s = laser_gun.instance()
		add_child(s)
	
	if current_weapon == "phaser":
		CurrentWeaponIcon.current_icon = CurrentWeaponIcon.PlayerPhaserIcon
	
	if current_weapon =="shotgun":
		for w in get_tree().get_nodes_in_group("player_weapon"):
			w.queue_free()
		var s = shotgun.instance()
		add_child(s)
		
	
	grapple()
	
	HealthBar.value = health
	
	if health <= 0:
		print("Player Died")
		player_death()
		queue_free()
	
	if Input.is_action_just_pressed("add_item"):
		var i = ItemIcon.instance()
		ItemIcons.add_child(i)
		pass
	
	var was_grounded = is_on_ground
	is_on_ground = is_on_floor()
	
	if was_grounded == null or is_on_ground != was_grounded:
		emit_signal("grounded_updated",is_on_ground)
		pass
	
	# Hook physics
func grapple():
	if Input.is_action_just_pressed("grapple"):
		if Hook.is_colliding():
			if not grappling:
				grappling = true
				print("grapple")
	
		if grappling:
			
			if not hook_point_get:
				hook_point = Hook.get_collision_point() + Vector2(0,0.25)
				hook_point_get = true
			if hook_point.distance_to(transform.origin) > 1:
				if hook_point_get:
					transform.origin =lerp(transform.origin,hook_point,0.5)
				else:
					grappling = false
					hook_point_get = false
					

func jump():
	if is_on_floor() or !CoyoteTimer.is_stopped() or !JumpBuffer.is_stopped(): 
			
#			SoundPlayer.stream = jump_sound
#			SoundPlayer.play()
			CoyoteTimer.stop()
			velocity.y = jump_speed
			is_jumping = true
	else:
			JumpBuffer.start()

func melee_hit(swing_direction):
	var s = sword_red.instance()
	if swing_direction == -1:
		s.scale.x = -1
	add_child(s)
	

	
func check_is_valid_wall(raycasts):
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			var dot = acos(Vector2.UP.dot(raycast.get_collision_normal()))
			if dot > PI * 0.35 and dot < PI * 0.5:
				return true
			
	return false

func update_wall_direction():
	var is_near_wall_left = check_is_valid_wall(RcLeft)
	var is_near_wall_right = check_is_valid_wall(RcRight)
	if is_near_wall_left and is_near_wall_right:
		wall_direction = 1
		pass
	else:
		wall_direction = -int(is_near_wall_left) + int(is_near_wall_right)

func player_death():
	var DS = DeathScreen.instance()
	get_parent().add_child(DS)
	get_tree().paused = true
	pass
	
func got_hit(damage_recieved):
	health -= damage_recieved
	AnimPlayer.play("damage_flash")
	SoundPlayer.stream = got_hit
	SoundPlayer.play()
	
	

func add_weapon(type):
	
	for w in WeaponMenu.get_children():
		if w.type == type:
			return
	var ws = WeaponSlot.instance()
	ws.type = type
	WeaponMenu.add_child(ws)
	

	for w in WeaponMenu.get_children():
		w.player = self
		w.grab_focus()
		w.add_to_group("weapon")
	current_weapon = type
	
func _on_ShootTimer_timeout():
	can_shoot = true
	WeaponShotParticles.emitting = false
	
	pass # Replace with function body.



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "portal_opening":
		AnimPlayer.stop()
		$PortalShaderSprite.visible = false
	if anim_name == "damage_flash":
		AnimPlayer.play("RESET")
	
	pass # Replace with function body.


func saved_game_popup():
	var p = SavedGamePopup.instance()
	$CanvasLayer.add_child(p)
	pass


func _on_Sprite_animation_finished():
	if AnimSprite.animation == "jump":
		AnimSprite.play("fall")
