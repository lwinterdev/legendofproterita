extends Node2D

var savepath

onready var player = $Player

var password = "123"

var save_path = "user://room_configs/MandelForest.ini"

var room_name = "MandelForest"

var player_spawn_position

func _ready():
	SaveAndLoadHandler.save_and_load_activated = true
	GlobalGameFilesHandler.current_hub = name
	GlobalGameFilesHandler.current_room = name

	GlobalMenuHandler.pause_menu_active = true
	for object in get_tree().get_nodes_in_group("minimap_objects"):
		object.connect("removed", $CanvasLayer/Minimap, "_on_object_removed")
	
	for room_changer in get_tree().get_nodes_in_group("room_changer"):
		room_changer.level = self
		room_changer.current_room = room_name
	
#	if GlobalRoomHandler.mandelforest_new == false:
#		GlobalRoomHandler.load_room(self,save_path,player)

func save_room():
	GlobalRoomHandler.save_room(self,save_path,player)
