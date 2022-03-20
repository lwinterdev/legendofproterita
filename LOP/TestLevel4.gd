extends Node2D

var room_name = "testlevel4"

onready var player = $Player

var save_path = "user://room_configs/testlevel4.ini"

var save_and_load_activated = true

var player_spawn_position

var level = self

var password = "123"

onready var SceneTransitionRect = $CanvasLayer/SceneTransitionRect

func _ready():
	
#	SceneTransitionRect.play_scene_transition_animation()
	
	for room_changer in get_tree().get_nodes_in_group("room_changer"):
		room_changer.level = self
		room_changer.current_room = room_name
	
	if GlobalRoomHandler.keystestlevel1_new == false:
		GlobalRoomHandler.load_room(self,save_path,player)
		GlobalPlayerInventory.load_inventory()
		
	GlobalRoomHandler.testlevel1_new = false
	SaveAndLoadHandler.save_and_load_activated = false
	SaveAndLoadHandler.level = self
#	PlayerSettingsHandler.load_settings()
	GlobalMenuHandler.pause_menu_active = true
	
	for node in get_children():
		if node.is_in_group("enemy"):
			node.target = $Player


func save_room():
	GlobalRoomHandler.save_room(self,save_path,player)
