extends Node2D

var settings_path = "user://player_settings.ini"

var bw_mode:bool
var fullscreen:bool
var recent_save_file

func _ready():
	pass
	
func load_settings():
	var PlayerSettingsConfig = ConfigFile.new()
	var err = PlayerSettingsConfig.load(settings_path)
	if err == OK:
		bw_mode = PlayerSettingsConfig.get_value("player_settings","bw_mode",false)
		fullscreen = PlayerSettingsConfig.get_value("player_settings","fullscreen",false)
		recent_save_file = PlayerSettingsConfig.get_value("player_settings","recent_save_file")
		OS.window_fullscreen = fullscreen
		print("File Found")
		
	else:
		print("File Not Found")
	
func save_settings():
	var PlayerSettingsConfig = ConfigFile.new()
	var err = PlayerSettingsConfig.save(settings_path)
	if err == OK:
		PlayerSettingsConfig.set_value("player_settings","bw_mode",bw_mode)
		PlayerSettingsConfig.set_value("player_settings","fullscreen",fullscreen)
		PlayerSettingsConfig.set_value("player_settings","recent_save_file",recent_save_file)
		PlayerSettingsConfig.save(settings_path)
		print("File Found")
		
	else:
		print("File Not Found")
	

func _physics_process(delta):
	if Input.is_action_just_pressed("load_settings"):
		load_settings()
