extends Area2D

var direction:int= 1
var speed:int = 150
var velocity = Vector2()
var damage:int = 5

var hitmarker = preload("res://PlayerHitmarker.tscn")

func _ready():
	pass

func set_direction(dir):
	direction = dir
	

func _physics_process(delta):
	position += transform.x * speed * delta
	


func _on_player_bullet_laser_body_entered(body):
	if body.is_in_group("wall"):
		var h = hitmarker.instance()
		get_parent().add_child(h)
		h.position = position
		queue_free()
	if body.is_in_group("enemy"):
		var h = hitmarker.instance()
		get_parent().add_child(h)
		h.position = position
		body.health -= damage
		body.got_hit(damage)
		queue_free()
		
	pass # Replace with function body.
	
