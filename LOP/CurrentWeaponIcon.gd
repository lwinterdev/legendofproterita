extends Sprite

var PlayerPhaserIcon = load("res://weapon_slot_cannon.png")
var PlayerLaserIcon = load("res://Sprites/player_bullet.png")

var current_icon

func _ready():
	texture = current_icon
	
func _physics_process(delta):
	texture = current_icon
