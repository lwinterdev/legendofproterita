extends Area2D

var direction:int= 1
var speed:int = 700/4
var velocity = Vector2()
var damage:int = 0
var owned

var bullet_hit_sound = preload("res://Sounds/mixkit-fast-blow-2144.wav")

var hitmarker = preload("res://PlayerHitmarker.tscn")

func _ready():
	pass

func set_direction(dir):
	direction = dir
	

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_EnemyBullet_body_entered(body):
	if body.is_in_group("wall"):
		var h = hitmarker.instance()
		get_parent().add_child(h)
		
		h.position = position
		queue_free()
		
		
	if body.is_in_group("player"):
		var h = hitmarker.instance()
		get_parent().add_child(h)
		h.position = position
		
		body.got_hit(damage)
		queue_free()
	pass # Replace with function body.
