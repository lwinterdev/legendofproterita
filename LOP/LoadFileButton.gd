extends Button

signal file_loaded(file_name)

var file_path =""

var file_name

var saved_room

var time_played 

onready var RoomValueLabel = $HBoxContainer/Panel/RoomValueLabel
onready var TimeValueLabel = $HBoxContainer/Panel/TimeValueLabel

func _ready():
	text = file_name
	RoomValueLabel.text = saved_room
	TimeValueLabel.text = time_played
	
	
func _on_LoadFileButton_pressed():
	emit_signal("file_loaded",file_name)

