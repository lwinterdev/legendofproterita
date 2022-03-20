extends Area2D

var damage = 5

var target

func _on_wood_spikes_body_entered(body):
	if body.is_in_group("player"):
		body.got_hit(damage)
		target = body
	pass # Replace with function body.

func _physics_process(delta):
	if target:
		target.got_hit(0.1)


func _on_wood_spikes_body_exited(body):
	if body.is_in_group("player"):
		target = null
	pass # Replace with function body.
