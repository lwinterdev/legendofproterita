extends Control

var SpaceshipCutscene = "res://SpaceCutscene.tscn"


func _ready():
	get_tree().paused = true
	pass

func _on_SpaceshipStartButton_pressed():
	GlobalSceneHandler.goto_scene(SpaceshipCutscene)
	pass # Replace with function body.


func _on_SpaceshipCancelButton_pressed():
	get_tree().paused = false
	queue_free()
	pass # Replace with function body.
