extends Control

signal sub_menu_closed()
signal update_save_menu()

var save_path_dir = "user://game_saves/"

var player

var num_save_files:int = 0
var max_save_files:int = 10
var save_files = []

var SaveFilePopup = preload("res://SaveFilePopup.tscn")

var SavedGameFilePopup = preload("res://SaveGamePopup.tscn")

onready var ButtonContainer = $ColorRect/ScrollContainer/VBoxContainer
#onready var NewSaveFileButton = $ColorRect/CenterContainer/VBoxContainer/NewSaveFileButton

var SaveGameFileButton = preload("res://SaveFileButton.tscn")

var current_hub

var time_played

var current_room

func _ready():
	time_played = GlobalPlayerInventory.time_played
	current_room = GlobalGameFilesHandler.current_room
	$ColorRect/ScrollContainer/VBoxContainer/NewSaveFileButton.grab_focus()
	
	dir_contents(save_path_dir)
	for f in save_files:
		var l = SaveGameFileButton.instance()
		var split_name = f.rsplit(".", true, 1)
		l.file_name = split_name[0]
		l.saved_room = current_room
		var LoadConfig = ConfigFile.new()
		var err = LoadConfig.load(save_path_dir + f)
		
		if err != OK:
			print("file not found")
			return
			
		l.saved_room = LoadConfig.get_value("saved_room","saved_room","no room")
		l.time_played = LoadConfig.get_value("time_played","time_played","time")
		ButtonContainer.add_child(l)
		l.connect("file_saved",self,"save_game_file")
		
		
	num_save_files = save_files.size()
	print(num_save_files)
	
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


func _on_NewSaveFileButton_pressed():
	
	var p = SaveFilePopup.instance()
	add_child(p)
	p.connect("file_saved",self,"new_save_file")
	p.connect("sub_menu_closed",self,"sub_menu_closed")


func new_save_file(file_name):

	num_save_files += 1
	save_game_file(file_name,time_played)
	var fb = SaveGameFileButton.instance()
	fb.file_name = (file_name)
	fb.time_played = time_played
	fb.saved_room = current_room
	ButtonContainer.add_child(fb)


func save_game_file(file_name,time_played):
	print("saved")
	self.current_room = current_room
	self.time_played = time_played
	var save_path = ("user://game_saves/" + file_name + ".ini")
	PlayerSettingsHandler.recent_save_file = save_path
	PlayerSettingsHandler.save_settings()
	var SaveConfig = ConfigFile.new()
	
	SaveConfig.set_value("time_played","time_played", time_played)
	
	SaveConfig.set_value("saved_room", "saved_room", current_room)
	
	SaveConfig.set_value("room_keys","spawn_house_key", GlobalRoomHandler.spawn_house_key)
	
#	var player_position = player.position
#	SaveConfig.set_value("player","player",player_position)
	
	SaveConfig.save(save_path)
	
	print("saved in: " + save_path)
	
	var p = SavedGameFilePopup.instance()
	add_child(p)
	emit_signal("update_save_menu")
	


func sub_menu_closed():
	$ColorRect/ScrollContainer/VBoxContainer/NewSaveFileButton.grab_focus()




func _on_CancelButton_pressed():
	emit_signal("sub_menu_closed")
	queue_free()
	

