extends Control

signal submenu_closed

onready var GameSpeedSlider = $ColorRect/CenterContainer/VBoxContainer/HBoxContainer/GameSpeedSlider
onready var GameSpeedValueLabel = $ColorRect/CenterContainer/VBoxContainer/HBoxContainer/GameSpeedValueLabel
onready var BackButton = $ColorRect/CenterContainer/VBoxContainer/AccesibilityMenuBackButton

func _ready():
	GameSpeedSlider.value = Engine.time_scale

func _physics_process(delta):
	GameSpeedValueLabel.text = str(Engine.time_scale * 100, " %") 
	BackButton.grab_focus()


func _on_GameSpeedSlider_value_changed(value):
	Engine.time_scale = value
	print(Engine.time_scale)
	
	pass # Replace with function body.


func _on_AccesibilityMenuBackButton_pressed():
	GlobalMenuHandler.option_menu_active = true
	emit_signal("submenu_closed")
	queue_free()
	pass # Replace with function body.
