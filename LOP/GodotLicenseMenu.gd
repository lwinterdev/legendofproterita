extends Control

signal sub_menu_closed()
	

func _on_LicensMenuBackButton_pressed():
	GlobalMenuHandler.pause_menu_active = true
	emit_signal("sub_menu_closed")
	queue_free()
	pass # Replace with function body.
