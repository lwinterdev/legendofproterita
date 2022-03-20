extends Area2D

var HitMarker = preload("res://PlayerHitmarker.tscn")

func _physics_process(delta):
	position += transform.x * 50* delta


func _on_TealTurretBullet_body_entered(body):
	if body.is_in_group("wall"):
		var h = HitMarker.instance()
		body.add_child(h)
		h.global_position = global_position
		queue_free()
	if body.is_in_group("player"):
		body.got_hit(5)
		var h = HitMarker.instance()
		body.add_child(h)
		h.global_position = global_position
		queue_free()
