extends Node2D

var room_name = "testlevel3"

onready var player = $Player

var save_path = "user://room_configs/testlevel3.ini"

var save_and_load_activated = true

var player_spawn_position

var level = self

var password = "123"

onready var SceneTransitionRect = $CanvasLayer/SceneTransitionRect

func _ready():
	
	SceneTransitionRect.play_scene_transition_animation()
	
	for room_changer in get_tree().get_nodes_in_group("room_changer"):
		room_changer.level = self
		room_changer.current_room = room_name
	
	if GlobalRoomHandler.testlevel3_new == false:
		GlobalRoomHandler.load_room(self,save_path,player)
	
	GlobalRoomHandler.testlevel3_new = false
	
	SaveAndLoadHandler.save_and_load_activated = false
	SaveAndLoadHandler.level = self
	GlobalMenuHandler.pause_menu_active = true
	
#	PlayerSettingsHandler.load_settings()
	

func save_room():
	GlobalRoomHandler.save_room(self,save_path,player)

