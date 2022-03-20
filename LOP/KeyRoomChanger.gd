extends Area2D

export var current_room = ""
export (String,FILE, "*.tscn") var goal_room
export var entered = false
export var boss_beaten = false
export var key1 = false
export var needed_key = false
var room_handler
var player
var level

onready var label = $Label

func _on_KeyRoomChanger_body_entered(body):
	if body.is_in_group("player") and entered == false and needed_key == true:
		print("change room to " + goal_room)

		level.player = body
		level.player_spawn_position = $PlayerSpawnPosition.global_position
		GlobalRoomHandler.player_spawn_position = $PlayerSpawnPosition.global_position
		level.save_room()
		GlobalPlayerInventory.save_inventory()
		entered = true
		GlobalSceneHandler.goto_scene(goal_room)
	pass # Replace with function body.

func _physics_process(delta):
#	label.text = str(key1)
	if GlobalRoomHandler.spawn_house_key == true:
		needed_key = true
		
