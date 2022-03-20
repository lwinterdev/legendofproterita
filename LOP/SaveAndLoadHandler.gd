extends Control

signal no_save_file()

var save_path = "user://game_saves/quicksave.ini"

var save_and_load_activated = false

var player

var player_spawn_position

var level

var password = "123"

var MandelForest = "res://MandelForest.tscn"

var time_played

func save_game():
	
	time_played = GlobalPlayerInventory.time_played
	
	var config = ConfigFile.new()
	
	config.set_value("saved_room", "saved_room", GlobalGameFilesHandler.current_room)
	config.set_value("time_played", "time_played", time_played)
	config.set_value("room_keys","spawn_house_key", GlobalRoomHandler.spawn_house_key)
	PlayerSettingsHandler.recent_save_file = save_path
	PlayerSettingsHandler.save_settings()
	
	config.save(save_path)
	
	
	player.saved_game_popup()
	

func load_game():

	var config = ConfigFile.new()
	var err = config.load(save_path)
	if err != OK:
		print("file not found")
		return
	
	var current_room = config.get_value("saved_room","saved_room", "MandelForest")
	GlobalPlayerInventory.time_played = config.set_value("time_played", "time_played", "time")
	GlobalRoomHandler.spawn_house_key = config.set_value("room_keys","spawn_house_key",false)
	GlobalPlayerInventory.measuring_time = true
	if current_room == "MandelForest":
		GlobalSceneHandler.goto_scene(MandelForest)
	
	
func load_recent_file():
	var RecentFileConfig = ConfigFile.new()
	var err1 = RecentFileConfig.load("user://player_settings.ini")
	if err1 !=OK:
		print("file not found")
		return
		
	var RecentFile = RecentFileConfig.get_value("player_settings","recent_save_file")
	var recent_save_path = RecentFile
	
	var config = ConfigFile.new()
	var err = config.load(recent_save_path)
	if err != OK:
		emit_signal("no_save_file")
		print("file not found")
		return
	
	var current_room = config.get_value("saved_room","saved_room", "MandelForest")
	if current_room == "MandelForest":
		GlobalSceneHandler.goto_scene(MandelForest)
	
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("save_game") and save_and_load_activated==true:
		save_game()
		print("saved game")
#	if Input.is_action_just_pressed("load_game") and save_and_load_activated==true:
#		load_game()
#		print("loaded game")
	
