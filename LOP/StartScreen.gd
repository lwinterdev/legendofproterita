extends Control

var MainMenu ="res://GameScenes/MainMenu.tscn"
var TestSound = "res://Sounds/trancelike.wav"
var MandelForest = "res://MandelForest.tscn"

onready var StartButton = $CenterContainer/StartScreenContinueButton

func _ready():
	StartButton.grab_focus()
	

func _on_StartScreenContinueButton_pressed():
	GlobalSceneHandler.goto_scene(MainMenu)
