extends Control

signal quit_confirm_menu_closed

var MainMenu = "res://GameScenes/MainMenu.tscn"
onready var NoButton = $ColorRect/CenterContainer/VBoxContainer/HBoxContainer/QuitNoButton

func _ready():
	NoButton.grab_focus()
	NoButton.grab_click_focus()


func _on_QuitYesButton_pressed():
#	emit_signal("quit_confirm_menu_closed")
	GlobalPlayerInventory.stop_play_timer()
	GlobalSceneHandler.goto_scene(MainMenu)
	queue_free()
	pass # Replace with function body.


func _on_QuitNoButton_pressed():
	emit_signal("quit_confirm_menu_closed")
	queue_free()
	pass # Replace with function body.



func _on_QuitYesButton_mouse_entered():
	print("ok")
	pass # Replace with function body.
