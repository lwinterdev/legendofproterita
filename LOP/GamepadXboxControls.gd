extends Control

signal submenu_closed

onready var BackButton = $ColorRect/CenterContainer/VBoxContainer/BackButton

func _ready():
	BackButton.grab_focus()
	
	
func _on_BackButton_pressed():
	GlobalMenuHandler.option_menu_active = true
	emit_signal("submenu_closed")
	queue_free()
	pass # Replace with function body.
