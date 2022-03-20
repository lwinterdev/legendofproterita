extends Control

var TestLevel = "res://TestLevel.tscn"
var LoadMenu = preload("res://LoadGameMenu.tscn")
var OptionsMenu = preload("res://OptionsMenu.tscn")
var TestScroll = "res://TestScroll.tscn"
var LicenseMenu = preload("res://GodotLicenseMenu.tscn")
var MandelForest = preload("res://MandelForest.tscn")
var QuitConfirmationMenu = preload("res://QuitConfirmationMenu.tscn")

#sound variables
onready var StartButton = $CenterContainer/VBoxContainer/MainMenuStartButton

onready var SoundPlayer = $MainMenuSoundPlayer
onready var MusicPlayer = $MainMenuMusicPlayer
var hover_sound = preload("res://Sounds/mixkit-small-hit-in-a-game-2072.wav")
var press_sound = preload("res://Sounds/mixkit-unlock-game-notification-253.wav")



func _ready():
	SaveAndLoadHandler.connect("no_save_file",self,"no_save_file")
	get_tree().paused = false
	GlobalMenuHandler.main_menu_active = true
#	SaveAndLoadHandler.save_and_load_activated = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
	PlayerSettingsHandler.load_settings()
	OS.window_fullscreen = false
	
func _physics_process(delta):
	
	visible = true
		
	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up") and GlobalMenuHandler.main_menu_active:
		SoundPlayer.stream = hover_sound
		SoundPlayer.play()
		

func _on_MainMenuStartButton_pressed():
	if GlobalMenuHandler.main_menu_active == true:
		SoundPlayer.stream = press_sound
		SoundPlayer.play()
		GlobalRoomHandler.new_game = true
		
		GlobalRoomHandler.key1 = false
		GlobalRoomHandler.spawn_house_new = true
		GlobalRoomHandler.place_of_comfort_new = true
		GlobalRoomHandler.secret_chamber_new = true
		GlobalRoomHandler.banana_garden_new = true
		GlobalRoomHandler.swamp_of_things_new = true
		GlobalRoomHandler.tree_of_things_new = true
		GlobalRoomHandler.chamber_of_things_new = true
		GlobalRoomHandler.lair_of_insectia_new = true
		GlobalRoomHandler.crown_in_the_sky_new = true
		GlobalRoomHandler.spaceship_base_new = true
		GlobalPlayerInventory.start_play_timer()
		GlobalSceneHandler.goto_scene(TestScroll)


func _on_MainMenuQuitButton_pressed():
	if GlobalMenuHandler.main_menu_active == true:
		var qm = QuitConfirmationMenu.instance()
		add_child(qm)
		get_node("QuitConfirmationMenu").connect("quit_confirm_menu_closed", self, "quit_confirm_menu_closed")
		GlobalMenuHandler.pause_menu_active = false


func _on_MainMenuOptionsButton_pressed():
	if GlobalMenuHandler.main_menu_active == true:
		
		var om = OptionsMenu.instance()
		add_child(om)
		get_node("OptionsMenu").connect("options_menu_closed", self, "options_menu_closed")
		GlobalMenuHandler.main_menu_active = false


func _on_MainMenuMusicPlayer_finished():
	MusicPlayer.play()


func _on_MainMenuLoadButton_pressed():
	var l = LoadMenu.instance()
	add_child(l)
	l.connect("sub_menu_closed",self,"options_menu_closed")


func _on_MainMenuLicenseButton_pressed():
	if GlobalMenuHandler.pause_menu_active == true:
		var lm = LicenseMenu.instance()
		add_child(lm)
		lm.connect("sub_menu_closed",self,"options_menu_closed")
		GlobalMenuHandler.pause_menu_active = false


func options_menu_closed():
	StartButton.grab_focus()
	visible = true


func quit_confirm_menu_closed():
	GlobalMenuHandler.pause_menu_active = true
	StartButton.grab_focus()


func _on_MainMenuContinueButton_pressed():
	SaveAndLoadHandler.load_recent_file()


func no_save_file():
	$CenterContainer/VBoxContainer/MainMenuContinueButton.disabled = true
	print("no save file")
