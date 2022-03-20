signal weapon_selected

extends Button

var BulletLaserIcon = load("res://weapon_sprite_laser.png")
var BulletPhaserIcon = load("res://weapon_slot_cannon.png")
var BulletShotgunIcon = load("res://Sprites/shotgun_pickup.png")
var SwordRedIcon = load("res://Sprites/sword_red_pickup.png")

onready var WeaponIcon = $WeaponIcon

var player = load("res://Player.tscn")
var type = "laser"

#sound variables
onready var SoundPlayer = $WeaponSlotSoundPlayer
var select_sound = preload("res://Sounds/mixkit-retro-arcade-casino-notification-211.wav")

func _ready():
	if type == "phaser":
		WeaponIcon.texture = BulletPhaserIcon
	
	if type == "laser":
		WeaponIcon.texture = BulletLaserIcon
		
	if type == "sword_red":
		WeaponIcon.texture = SwordRedIcon
		
	if type == "shotgun":
		WeaponIcon.texture = BulletShotgunIcon
	
	add_to_group("weapon")
	
func _on_WeaponSlotButton_pressed():
	player.current_weapon= type
	
	SoundPlayer.stream = select_sound
	SoundPlayer.play()
	
	emit_signal("weapon_selected")
	pass # Replace with function body.
