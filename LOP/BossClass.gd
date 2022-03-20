extends KinematicBody2D

export (int) var speed = 200
export (int) var base_speed = 300
export (int) var jump_speed = -600
export (int) var gravity = 32
export (int) var max_gravity = 32
var Floor = Vector2(0,-1)
export (int) var melee_damage := 10


export (float, 0, 1.0) var friction = 0.25
export (float, 0, 1.0) var acceleration = 0.5

export (float , 0, 100) var health = 100

var velocity = Vector2.ZERO
var is_jumping := false
var is_falling := false

var react_time := 100
var moving_left:= true

var next_direction = 0
var next_direction_time = 0  

var direction :int = 0

var target_distance:int = 100

#load death animation
var death_animation = preload("res://EnemyClassDeath.tscn")

var target = null
onready var Look =$Look
onready var LookDirection = $EnemyLookDirection
onready var AggroDirection = $EnemyAggroDirection
var bullet = preload("res://EnemyBullet.tscn")
var can_shoot:bool = true
onready var ShootTimer = $ShootTimer

#sound variables
onready var SoundPlayer = $EnemySoundPlayer
var bullet_hit_sound_wall = preload("res://Sounds/mixkit-fast-blow-2144.wav")
var bullet_hit_sound_player = preload("res://Sounds/mixkit-small-hit-in-a-game-2072.wav")

var state = "idle"

func _physics_process(delta):
	
	velocity.y += gravity
	
	if not AggroDirection.is_colliding():
		velocity.x = speed * direction
	
	
	velocity = move_and_slide(velocity)
	
	if target:
		LookDirection.look_at(target.position)
		AggroDirection.look_at(target.position)
		if state == "chase":
				
			if target.position.x > position.x + target_distance and next_direction != 1 : #turn to right side 
				
				set_direction(1)
				
				
			elif target.position.x < position.x - target_distance  and next_direction != -1: #turn to left side
				
				set_direction(-1)
				
			
			elif target.position.x == position.x  and next_direction != 0:
				
				set_direction(0)
				
			if OS.get_ticks_msec() > next_direction_time:
				direction = next_direction
	
			
		
			
			
			if can_shoot and not $EnemyLookDirection/RayCast2D.is_colliding():
				var b = bullet.instance()
				get_parent().add_child(b)
				b.owned = self
				b.transform =LookDirection.transform
				b.position = $Position2D.global_position
				ShootTimer.start()
				can_shoot = false
			
		
	if health <= 0: 
		death()
		
func set_direction(new_direction):
	if next_direction != new_direction:
		next_direction = new_direction
		next_direction_time = OS.get_ticks_msec() + react_time
	pass

func got_hit(recieved_damage):
	health -= recieved_damage
	$FlashTimer.start()
	$ColorRect.visible = true

func play_bullet_sound_wall():
	SoundPlayer.stream = bullet_hit_sound_wall
	SoundPlayer.play()

func play_bullet_sound_hit_player():
	SoundPlayer.stream = bullet_hit_sound_player
	SoundPlayer.play()

func death():
	var d = death_animation.instance()
	d.global_position =  global_position
	get_parent().add_child(d)
	
	queue_free()


func _on_AggroArea_body_entered(body):
	if body.is_in_group("player"):
		state = "chase"
		target = body
		speed = base_speed



func _on_AggroArea_body_exited(body):
	if body.is_in_group("player"):
		state = "idle"
		speed = 0
	pass # Replace with function body.



func _on_Hitbox_body_entered(body):
	if body.is_in_group("player") :
		body.got_hit(melee_damage)
		speed = 0
		$MeleeTimer.start()
	pass # Replace with function body.


func _on_MeleeTimer_timeout():
	speed = base_speed
	$MeleeTimer.stop()
	pass # Replace with function body.


func _on_FlashTimer_timeout():
	$ColorRect.visible = false
	pass # Replace with function body.


func _on_ShootTimer_timeout():
	can_shoot = true
	pass # Replace with function body.
