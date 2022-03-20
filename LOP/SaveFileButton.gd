extends Button

signal file_saved(file_name,time_played)

var file_path =""

var file_name

var saved_room = ""

var time_played = "0"

onready var RoomValueLabel = $HBoxContainer/Panel/RoomValueLabel
onready var TimeValueLabel = $HBoxContainer/Panel/TimeValueLabel

func _ready():
	text = file_name
	RoomValueLabel.text = saved_room
	TimeValueLabel.text = time_played


func _on_SaveFileButton_pressed():
	emit_signal("file_saved",file_name,time_played)
	pass # Replace with function body.
