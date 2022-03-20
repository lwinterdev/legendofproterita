extends Control

signal submenu_closed

func _ready():
	GlobalMenuHandler.general_menu_active = true

func _on_GeneralOptionsMenuBackButton_pressed():
	GlobalMenuHandler.option_menu_active = true
	GlobalMenuHandler.general_menu_active = false
	emit_signal("submenu_closed")
	queue_free()
	pass # Replace with function body.


func _on_OptionButton_item_selected(index):
	print(index)
	if index == 0:
		TranslationServer.set_locale("de")
	if index == 1:
		TranslationServer.set_locale("en")





func _on_CheckBox_pressed():
	OS.window_fullscreen = true
	PlayerSettingsHandler.fullscreen = true
	PlayerSettingsHandler.save_settings()
	pass # Replace with function body.


func _on_GeneralOptionsDisplayModeButton_item_selected(index):
	if index == 0:
		OS.window_fullscreen = true
		OS.window_borderless = false
		
	if index == 1:
		OS.window_fullscreen = false
		OS.window_borderless = false
		
	if index == 2:
		OS.window_fullscreen = false
		OS.window_borderless = true
	pass # Replace with function body.


func _on_GeneralOptionsVsyncButton_toggled(button_pressed):
	if button_pressed == true:
		OS.vsync_enabled = true
	else: 
		OS.vsync_enabled = false
	pass # Replace with function body.
