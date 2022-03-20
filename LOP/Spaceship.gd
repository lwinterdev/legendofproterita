extends StaticBody2D

var spaceship_menu = preload("res://SpaceshipMenu.tscn")

onready var anim_player = $AnimationPlayer


func _ready():
	anim_player.play("blink")

func _on_TriggerArea_body_entered(body):
	var s = spaceship_menu.instance()
	add_child(s)
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "blink":
		anim_player.play("blink")
	pass # Replace with function body.
