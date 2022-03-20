extends Node2D

var main_menu = "res://GameScenes/MainMenu.tscn"

func _ready():
	get_tree().paused = false

func _on_Button_pressed():
	GlobalSceneHandler.goto_scene(main_menu)
	pass # Replace with function body.
