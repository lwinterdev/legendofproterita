extends KinematicBody2D

var health = 20
var target
onready var head = $ShootingPlantHead

func _physics_process(delta):
	if target:
		head.look_at(target.position)

func _on_AggroArea_body_entered(body):
	if body.is_in_group("player"):
		target = body
	pass # Replace with function body.
