extends Node2D

var controller_active:bool = false

func _ready():
	if Input.get_joy_name(0):
		controller_active = true

	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")

func _on_joy_connection_changed(device_id, connected):
	if connected:
		print(Input.get_joy_name(device_id))
		controller_active = true
	else:
		controller_active = false
		print("Keyboard")
		
func _input(event):
	if event is InputEventMouseMotion :
		controller_active = false
#	elif event is InputEventJoypadMotion or InputEventJoypadButton:
#		controller_active = true
