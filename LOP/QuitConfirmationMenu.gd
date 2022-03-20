extends Control

signal quit_confirm_menu_closed

onready var NoButton = $ColorRect/CenterContainer/VBoxContainer/HBoxContainer/QuitNoButton

func _ready():
	NoButton.grab_focus()


func _on_QuitYesButton_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_QuitNoButton_pressed():
	emit_signal("quit_confirm_menu_closed")
	queue_free()
	pass # Replace with function body.
