extends Control

signal submenu_closed

var resolution

func _ready():
	print(OS.get_screen_size())
	$ColorRect/CenterContainer/VBoxContainer/HBoxContainer/OptionButton.grab_focus()
	
func _on_OptionButton_item_selected(index):
	match index:
		0:
			resolution = Vector2(1920,1200)
		1:
			resolution = Vector2(1920,1080)
		2:
			resolution = Vector2(1280,720)
		3:
			resolution = Vector2(640,360)
		4:
			resolution = Vector2(1920,1200)
		5:
			resolution = Vector2(1920,1200)
			
	OS.set_window_size(resolution)
	pass # Replace with function body.


func _on_Button_pressed():
	GlobalMenuHandler.option_menu_active = true
	emit_signal("submenu_closed")
	queue_free()
	pass # Replace with function body.
