extends KinematicBody2D

onready var AnimPlayer = $AnimationPlayer

func _ready():
	AnimPlayer.play("dissolve")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "dissolve":
		queue_free()
	pass # Replace with function body.
