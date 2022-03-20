extends Control

onready var AnimPlayer = $Camera2D/AnimationPlayer
onready var Cam = $Camera2D
onready var NextButton = $CenterContainer/Button


var MandelForest = "res://MandelForest.tscn"
var SpawnHouse = "res://SpawnHouse.tscn"
var PlaceOfComfort = "res://PlaceOfComfort.tscn"

var scroll_finished = false

func _ready():
	AnimPlayer.play("camera_scroll")
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_accept") and scroll_finished == false:
		AnimPlayer.stop()
		Cam.position.y = 1000
		AnimPlayer.play("button_fade")
		AnimPlayer.playback_speed = 1
		scroll_finished = true
		NextButton.grab_focus()
		pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "camera_scroll":
		AnimPlayer.play("button_fade")
		AnimPlayer.playback_speed = 1
		scroll_finished = true
		NextButton.grab_focus()
	pass # Replace with function body.


func _on_Button_pressed():
	GlobalSceneHandler.goto_scene(PlaceOfComfort)
	pass # Replace with function body.
