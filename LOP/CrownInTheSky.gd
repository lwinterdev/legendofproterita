extends Node2D

onready var player = $Player

var room_name = "CrownInTheSky"

var save_path = "user://room_configs/CrownInTheSky.ini"

var player_spawn_position

func _ready():
	GlobalMenuHandler.weapon_menu_active = false
	for room_changer in get_tree().get_nodes_in_group("room_changer"):
		room_changer.level = self
		room_changer.current_room = room_name
	
	GlobalGameFilesHandler.current_hub = name
	GlobalGameFilesHandler.current_room = name
	
	SaveAndLoadHandler.save_and_load_activated = true
	SaveAndLoadHandler.level = self
	GlobalMenuHandler.pause_menu_active = true
	
	if GlobalRoomHandler.crown_in_the_sky_new== false:
		GlobalRoomHandler.load_room(self,save_path,player)
		
	GlobalRoomHandler.crown_in_the_sky_new = false

func save_room():
	GlobalRoomHandler.save_room(self,save_path,player)
