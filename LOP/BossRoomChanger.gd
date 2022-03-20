extends Area2D

export var current_room = ""
export (String,FILE, "*.tscn") var goal_room
export var entered = false
export var boss_beaten = false

var room_handler
var player
var level

func _on_BossRoomChanger_body_entered(body):
	if body.is_in_group("player") and entered == false and boss_beaten == true:
		print("change room to " + goal_room)

		level.player = body
		level.player_spawn_position = $PlayerSpawnPosition.global_position
		GlobalRoomHandler.player_spawn_position = $PlayerSpawnPosition.global_position
		level.save_room()
		GlobalPlayerInventory.save_inventory()
		entered = true
		get_tree().change_scene(goal_room)
	pass # Replace with function body.
