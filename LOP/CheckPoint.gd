extends Area2D

var SaveGamePopup = load("res://SaveGamePopup.tscn")

func _on_CheckPoint_body_entered(body):
	if body.is_in_group("player"):
		print("game saved")
		SaveAndLoadHandler.player_spawn_position = $SpawnPosition.global_position
		SaveAndLoadHandler.save_game()
		var s = SaveGamePopup.instance()
		add_child(s)
	pass # Replace with function body.


