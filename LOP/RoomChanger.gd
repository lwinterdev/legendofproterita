extends Area2D

export var current_room = ""
export (String,FILE, "*.tscn") var goal_room
export var entered = false
export var boss_beaten = true

var room_handler
var player
var level

var player_spawn_position

func _ready():

#	GlobalRoomHandler.current_room = current_room
	entered = false
#	level.player_spawn_position = $PlayerSpawnPosition.position
	

func _on_RoomChanger_body_entered(body):
	if body.is_in_group("player") and entered == false and boss_beaten == true:
		print("change room to " + goal_room)

		level.player = body
		level.player_spawn_position = $PlayerSpawnPosition.global_position
		GlobalRoomHandler.player_spawn_position = $PlayerSpawnPosition.global_position
		level.save_room()
		GlobalPlayerInventory.save_inventory()
		entered = true
		GlobalSceneHandler.goto_scene(goal_room)
	
func _on_RoomChanger_body_exited(body):
	if body.is_in_group("player") :
		print("started" + current_room)
		

