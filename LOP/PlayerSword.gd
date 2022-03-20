extends Area2D

var damage = 4



func _on_PlayerSword_body_entered(body):
	if body.is_in_group("enemy"):
		body.got_hit(damage)
	pass # Replace with function body.


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
