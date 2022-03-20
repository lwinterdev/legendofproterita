extends Control

signal sub_menu_closed()

var save_path_dir = "user://game_saves/"

var player

var num_save_files:int = 0
var save_files = []

var SaveFilePopup = preload("res://SaveFilePopup.tscn")
#var LoadFilePopup = preload("res://LoadFilePopup.tscn")

#var GameLoadedFilePopup = preload("res://GameLoadedFilePopup.tscn")

onready var ButtonContainer = $ColorRect/ScrollContainer/VBoxContainer
#onready var SaveFilesLabel = $ColorRect/CenterContainer/VBoxContainer/SaveFilesLabel


var LoadGameFileButton = preload("res://LoadFileButton.tscn")

var current_hub

var MandelForest = "res://MandelForest.tscn"
var SpawnHouse = "res://SpawnHouse.tscn"
var PlaceOfComfort = "res://PlaceOfComfort.tscn"

func _ready():
	
	
	dir_contents(save_path_dir)
	for f in save_files:
		var l = LoadGameFileButton.instance()
		var split_name = f.rsplit(".", true, 1)
	
		l.file_name = split_name[0]
		var LoadConfig = ConfigFile.new()
		var err = LoadConfig.load(save_path_dir + f)
		
		if err != OK:
			print("file not found")
			return
			
		l.saved_room = LoadConfig.get_value("saved_room","saved_room","no room")
		l.time_played = LoadConfig.get_value("time_played","time_played","time")
		GlobalPlayerInventory.measuring_time = true
		ButtonContainer.add_child(l)
		l.connect("file_loaded",self,"load_game_file")
		

		print(l.saved_room)
		
		
#	if save_files.size() == 0:
#		SaveFilesLabel.text = "No Save Files Yet"
#	else:
#		SaveFilesLabel.text = ""
		$ColorRect/ScrollContainer/VBoxContainer/BackButton.grab_focus()
	
func _process(delta):
	if Input.is_action_pressed("ui_down"):
		$ColorRect/ScrollContainer.scroll_vertical += 1 
	if Input.is_action_pressed("ui_up"):
		$ColorRect/ScrollContainer.scroll_vertical -= 1 
	
	
func dir_contents(path):
	
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				save_files.append(file_name)
				file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	return save_files


func load_game_file(file_name):
	var save_path = ("user://game_saves/" + file_name + ".ini")
	var SaveConfig = ConfigFile.new()
	var err = SaveConfig.load(save_path)
	if err != OK:
		print("file not found")
		return
		
	var saved_room = SaveConfig.get_value("saved_room","saved_room")
	GlobalRoomHandler.spawn_house_key =SaveConfig.get_value("room_keys","spawn_house_key")
	print(saved_room)
	if saved_room == "MandelForest":
		GlobalSceneHandler.goto_scene(MandelForest)
	elif saved_room == "SpawnHouse":
		GlobalSceneHandler.goto_scene(SpawnHouse)
	elif saved_room == "PlaceOfComfort":
		GlobalSceneHandler.goto_scene(PlaceOfComfort)
	elif saved_room == "SecretChamber":
		GlobalSceneHandler.goto_scene(PlaceOfComfort)
		
		
#	player.position = SaveConfig.get_value("player", "position")
	
	print("file " + file_name + " loaded")
	
#	var p = GameLoadedFilePopup.instance()
#	add_child(p)
	
	get_tree().paused = false
	queue_free()
	
	pass


func _on_BackButton_pressed():
	emit_signal("sub_menu_closed")
	queue_free()



