extends Control

var save_path_dir = "user://game_saves/"

signal submenu_closed

var player

var num_save_files:int = 0
var save_files = []

var SaveFilePopup = preload("res://SaveFilePopup.tscn")
#var LoadFilePopup = preload("res://LoadFilePopup.tscn")

#var GameLoadedFilePopup = preload("res://GameLoadedFilePopup.tscn")

onready var ButtonContainer = $LoadGameMenu/ButtonContainer
#onready var SaveFilesLabel = $ColorRect/CenterContainer/VBoxContainer/SaveFilesLabel
onready var BackButton = $VBoxContainer/BackButton

var LoadGameFileButton = preload("res://LoadFileButton.tscn")

var current_hub


func _ready():

	dir_contents(save_path_dir)
	for f in save_files:
		var l = LoadGameFileButton.instance()
		var split_name = f.rsplit(".", true, 1)
	
		l.file_name = split_name[0]
		ButtonContainer.add_child(l)
		
		l.connect("file_loaded",self,"load_game_file")
		
		var LoadConfig = ConfigFile.new()
		var err = LoadConfig.load(save_path_dir + f)
		
		if err != OK:
			print("file not found")
			return
		l.time_played = LoadConfig.get_value("played_time","played_time")
		
#	if save_files.size() == 0:
#		SaveFilesLabel.text = "No Save Files Yet"
#	else:
#		SaveFilesLabel.text = ""
	
func _process(delta):
	pass
	
	
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
		
	var current_room = SaveConfig.get_value("saved_room", "saved_room" , "res://PlaceOfComfort.tscn")
		
	var time_played = SaveConfig.get_value("played_time","played_time","0")
	
	print(current_room)
	
	GlobalSceneHandler.goto_scene(current_room)
	
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.queue_free()

	var enemies = SaveConfig.get_value("enemies", "enemies")
	
	for enemy_config in enemies:
		var enemy = preload("res://BossClass.tscn").instance()
		enemy.position = enemy_config.position
#		enemy.health = enemy_config.health
		current_hub.add_child(enemy)
	
#	player.position = SaveConfig.get_value("player", "position")
	
	print("file " + file_name + " loaded")
	
#	var p = GameLoadedFilePopup.instance()
#	add_child(p)
	
	get_tree().paused = false
	queue_free()
	
	pass


func _on_BackButton_pressed():
	visible = false
	emit_signal("submenu_closed")
