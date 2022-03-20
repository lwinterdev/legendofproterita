extends Area2D

var direction:int= 1
var speed:int = 150
var velocity = Vector2()
var damage:int = 10
var owned

var hitmarker = preload("res://PlayerHitmarker.tscn")

onready var SoundPlayer = $PlayerBulletSoundPlayer
var wall_sound = preload("res://Sounds/mixkit-fast-blow-2144.wav")

	
func set_direction(dir):
	direction = dir
	

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Area2D_body_entered(body):
	if body.is_in_group("wall"):
		var h = hitmarker.instance()
		get_parent().add_child(h)
		h.position = position
		queue_free()
		
		
	if body.is_in_group("enemy"):
		var h = hitmarker.instance()
		get_parent().add_child(h)
		h.position = position
		body.got_hit(damage)
		queue_free()
		
	pass # Replace with function body.

