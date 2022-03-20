extends Control

var MainMenu = load("res://GameScenes/MainMenu.tscn")
var OptionsMenu = load("res://OptionsMenu.tscn")
var SaveGameMenu = load("res://SaveGameMenu.tscn")
var ReturnToMainMenuConfirmationMenu = load("res://ReturnToMainMenuConfirmationMenu.tscn")
onready var ResumeButton = $CenterContainer/VBoxContainer/PauseMenuResumeButton

#sound variables
onready var SoundPlayer = $PauseMenuSoundPlayer

func _ready():
	visible = false
	
	
func _physics_process(delta):
	if Input.is_action_just_pressed("pause") and GlobalMenuHandler.pause_menu_active:
		if visible == false:
			GlobalMenuHandler.weapon_menu_active = false
			get_tree().paused = true
			visible = true
			ResumeButton.grab_focus()
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		
		
func _on_PauseMenuResumeButton_pressed():
	get_tree().paused = false
	visible = false
	GlobalMenuHandler.weapon_menu_active = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	pass # Replace with function body.


func _on_PauseMenuMainMenuButton_pressed():
	var qm = ReturnToMainMenuConfirmationMenu.instance()
	add_child(qm)
	get_node("ReturnToMainMenuConfirmationMenu").connect("quit_confirm_menu_closed", self, "quit_confirm_menu_closed")
	pass # Replace with function body.


func _on_PauseMenuOptionsButton_pressed():
	var om = OptionsMenu.instance()
	om.pm = self
	add_child(om)
	get_node("OptionsMenu").connect("options_menu_closed", self, "options_menu_closed")
	pass # Replace with function body.

func options_menu_closed():
	ResumeButton.grab_focus()
	
func quit_confirm_menu_closed():
	ResumeButton.grab_focus()


func _on_PauseMenuSaveGameButton_pressed():
	var s = SaveGameMenu.instance()
	add_child(s)
	s.connect("sub_menu_closed",self,"quit_confirm_menu_closed")
	s.connect("update_save_menu",self,"update_save_menu")


func update_save_menu():
	get_node("SaveGameMenu").queue_free()
	var s = SaveGameMenu.instance()
	add_child(s)
	s.connect("sub_menu_closed",self,"quit_confirm_menu_closed")
	

