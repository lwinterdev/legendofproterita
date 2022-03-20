extends Area2D

export var beam_direction = "up"

export var beam_strenght = 250/5


func _on_tractor_beam_body_entered(body):
	if body.is_in_group("player"):
		if beam_direction == "up":
			body.gravity = -beam_strenght
		if beam_direction == "down":
			body.gravity = beam_strenght
	pass # Replace with function body.


func _on_tractor_beam_body_exited(body):
	if body.is_in_group("player"):
		if beam_direction == "up":
			body.gravity = 1000/4
		if beam_direction == "down":
			body.gravity = 1000/4
	pass # Replace with function body.

#func _physics_process(delta):
#	if Input.is_action_just_pressed("look_up"):
#		beam_direction = "up"
#	if Input.is_action_just_pressed("look_down"):
#		beam_direction = "down"
