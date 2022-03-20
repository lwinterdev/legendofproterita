extends CanvasLayer

var MainMenu = load("res://GameScenes/MainMenu.tscn")

func _ready():
	SaveAndLoadHandler.save_and_load_activated = false
	pass


func _on_DeathScreenMainMenuButton_pressed():
	get_tree().change_scene_to(MainMenu)
	pass # Replace with function body.


func _on_DeathScreenLoadLastSaveButton_pressed():
	get_tree().paused = false
	SaveAndLoadHandler.load_recent_file()
	pass # Replace with function body.
