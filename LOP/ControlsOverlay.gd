extends Panel

onready var ControlLabel = $ControlOverlaySprit/ControlLabel
onready var ControlOverlaySprite = $ControlOverlaySprit

var xbox_xbutton_texture = load("res://Sprites/ControlsOverlay/xbox_xbutton.png")
var xbox_bbutton_texture = load("res://Sprites/ControlsOverlay/xbox_bbutton.png")
var xbox_abutton_texture = load("res://Sprites/ControlsOverlay/xbox_abutton.png")
var xbox_ybutton_texture = load("res://Sprites/ControlsOverlay/xbox_ybutton.png")

var xbox_dpad_texture = load("res://Sprites/ControlsOverlay/xbox_dpad2.png")

var xbox_leftstick_texture =load("res://Sprites/ControlsOverlay/xbox_leftstick.png")
var xbox_rightstick_texture =load("res://Sprites/ControlsOverlay/xbox_rightstick2.png")

var xbox_startbutton_texture =load("res://Sprites/ControlsOverlay/xbox_startbutton.png")
var xbox_selectbutton_texture =load("res://Sprites/ControlsOverlay/xbox_selectbutton.png")

var xbox_leftbumper_texture =load("res://Sprites/ControlsOverlay/xbox_leftbumper.png")
var xbox_rightbumper_texture =load("res://Sprites/ControlsOverlay/xbox_rightbumper.png")

var xbox_lefttrigger_texture =load("res://Sprites/ControlsOverlay/xbox_lefttrigger.png")
var xbox_righttrigger_texture =load("res://Sprites/ControlsOverlay/xbox_righttrigger.png")


var keyboard_button_texture =load("res://Sprites/ControlsOverlay/keyboard_simplekey.png")

export var key = "e"

export var xbox_button_type:String = ""

var button_type_texture

func _ready():
	match xbox_button_type:
		"x":
			button_type_texture = xbox_xbutton_texture
		"b":
			button_type_texture = xbox_bbutton_texture
		"a":
			button_type_texture = xbox_abutton_texture
		"y":
			button_type_texture = xbox_ybutton_texture
		"start":
			button_type_texture = xbox_startbutton_texture
		"select":
			button_type_texture = xbox_selectbutton_texture
		"leftstick":
			button_type_texture = xbox_leftstick_texture
		"rightstick":
			button_type_texture = xbox_rightstick_texture
		"dpad":
			button_type_texture = xbox_dpad_texture
		"rightbumper":
			button_type_texture = xbox_rightbumper_texture
		"leftbumper":
			button_type_texture = xbox_leftbumper_texture
		"righttrigger":
			button_type_texture = xbox_righttrigger_texture
		"lefttrigger":
			button_type_texture = xbox_lefttrigger_texture

			
	print(xbox_button_type)
	
	
	pass

func _physics_process(delta):
	if GlobalControlsHandler.controller_active == true:
		ControlLabel.text = ""
		ControlOverlaySprite.texture = button_type_texture
	else:
		ControlLabel.text = key
		ControlOverlaySprite.texture = keyboard_button_texture
