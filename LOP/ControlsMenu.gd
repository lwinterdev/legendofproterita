extends Control

signal submenu_closed

var SavePopup = preload("res://KeybindSavePopup.tscn")

onready var ButtonContainer = $ColorRect/Panel/CenterContainer/VBoxContainer
onready var BackButton = $ColorRect/HBoxContainer/ControlsMenuBackButton
var buttonscript = load("res://KeyButton.gd")
var keybinds

var buttons = {}

func _ready():
	BackButton.grab_focus()
	
	keybinds = Global.keybinds.duplicate()
	
	for key in keybinds.keys():
		var hbox = HBoxContainer.new()
		var label = Label.new()
		var button = Button.new()
		
		hbox.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		label.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		button.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		
		label.text = key
		
		var button_value = keybinds[key]
		button.text = OS.get_scancode_string(button_value)
		
		button.set_script(buttonscript)
		button.key = key
		button.value = button_value
		button.menu = self
		button.toggle_mode = true
		
		
		
		hbox.add_child(label)
		hbox.add_child(button)
		ButtonContainer.add_child(hbox)
		
		buttons[key] = button


func change_keybind(key,value):
	keybinds[key] = value
	for k in keybinds.keys():
		if k != key and value != null and keybinds[k] == value:
			keybinds[k] = null
			buttons[k].value = null
			buttons[k].text = "Unassigned"
	pass
	
func reset_keybinds():
	keybinds["move_right"] = 68
	keybinds["move_left"] = 65
	keybinds["jump"] = 32
	keybinds["toggle_weapon_menu"] = 81
	keybinds["interact"] = 69
	
	
func _on_ControlsMenuBackButton_pressed():
	GlobalMenuHandler.controls_menu_active = false
	GlobalMenuHandler.option_menu_active = true
	emit_signal("submenu_closed")
	queue_free()
	pass # Replace with function body.


func _on_ControlsMenuSaveButton_pressed():
	Global.keybinds = keybinds.duplicate()
	var p = SavePopup.instance()
	add_child(p)
	Global.set_game_binds()
	print(keybinds)
	Global.write_config()
	pass # Replace with function body.
	

func _on_ControlsMenuResetButton_pressed():
	reset_keybinds()
	print(keybinds)
	Global.keybinds = keybinds.duplicate()
	Global.write_config()

	pass # Replace with function body.
