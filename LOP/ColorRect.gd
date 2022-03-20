extends ColorRect

func _ready():
	
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("toggle_bw"):
		visible = PlayerSettingsHandler.bw_mode
		PlayerSettingsHandler.bw_mode = !visible
		print(PlayerSettingsHandler.bw_mode)
		PlayerSettingsHandler.save_settings()
