extends Control

signal options_menu_closed

var ControlsMenu = load("res://ControlsMenu.tscn")
var GamepadControlsMenu = load("res://GamepadXboxControls.tscn")
var pm
var GeneralOptionsMenu = load("res://GeneralOptionsMenu.tscn")
var AudioOptionsMenu = load("res://AudioOptionsMenu.tscn")
var VideoOptionsMenu = load("res://VideoOptionsMenu.tscn")
var AccesibilityMenu = load("res://AccesibilityMenu.tscn")

onready var BackButton = $ColorRect/CenterContainer/VBoxContainer/OptionsMenuBackButton

func _ready():
	visible = true
	GlobalMenuHandler.option_menu_active = true
	
func _on_OptionsMenuBackButton_pressed():
	if GlobalMenuHandler.option_menu_active == true:
		GlobalMenuHandler.main_menu_active = true
		GlobalMenuHandler.option_menu_active = false
		emit_signal("options_menu_closed")
		queue_free()
	pass
		

func _on_OptionsMenuControlsButton_pressed():
	if GlobalMenuHandler.option_menu_active == true:
		GlobalMenuHandler.option_menu_active = false
		var cm = ControlsMenu.instance()
		add_child(cm)
		get_node("ControlsMenu").connect("submenu_closed", self, "submenu_closed")
	pass # Replace with function body.


func _on_OptionsMenuGeneralButton_pressed():
	if GlobalMenuHandler.option_menu_active == true:
		GlobalMenuHandler.option_menu_active = false
		var gm = GeneralOptionsMenu.instance()
		add_child(gm)
		get_node("GeneralOptionsMenu").connect("submenu_closed", self, "submenu_closed")
	pass # Replace with function body.


func _on_OptionsMenuBackButton2_pressed():
	if GlobalMenuHandler.option_menu_active == true:
		GlobalMenuHandler.option_menu_active = false
		var am = AudioOptionsMenu.instance()
		add_child(am)
		get_node("AudioOptionsMenu").connect("submenu_closed", self, "submenu_closed")
	pass # Replace with function body.


func _on_OptionsMenuBackButton3_pressed():
	if GlobalMenuHandler.option_menu_active == true:
		GlobalMenuHandler.option_menu_active = false
		var vm= VideoOptionsMenu.instance()
		add_child(vm)
		get_node("VideoOptionsMenu").connect("submenu_closed", self, "submenu_closed")
	pass # Replace with function body.


func _on_OptionsMenuAccesibilityButton_pressed():
	if GlobalMenuHandler.option_menu_active == true:
		GlobalMenuHandler.option_menu_active = false
		var acm= AccesibilityMenu.instance()
		add_child(acm)
		get_node("AccesibilityMenu").connect("submenu_closed", self, "submenu_closed")
	pass # Replace with function body.


func submenu_closed():
	BackButton.grab_focus()
	pass


func _on_OptionsMenuControlsButtonGamepad_pressed():
	if GlobalMenuHandler.option_menu_active == true:
		GlobalMenuHandler.option_menu_active = false
		var gcm= GamepadControlsMenu.instance()
		add_child(gcm)
		get_node("GamepadXboxControls").connect("submenu_closed", self, "submenu_closed")
	pass # Replace with function body.
