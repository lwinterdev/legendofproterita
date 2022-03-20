extends Node2D

var deadzone := 0.1
var speed = 10

onready var crosshairs = $Crosshairs
var player

func _ready():
	
	
	InputMap.action_set_deadzone("aim_right",deadzone)
	InputMap.action_set_deadzone("aim_left",deadzone)
	InputMap.action_set_deadzone("aim_up",deadzone)
	InputMap.action_set_deadzone("aim_down",deadzone)

func _physics_process(delta):
	
	if GlobalControlsHandler.controller_active == true:
		
		var controllerangle = Vector2.ZERO
		var xAxisRL = Input.get_joy_axis(0, JOY_AXIS_2)
		var yAxisUD = Input.get_joy_axis(0 ,JOY_AXIS_3)
		controllerangle = Vector2(xAxisRL, yAxisUD).angle()
		rotation = controllerangle
		
#		Input.warp_mouse_position(crosshairs.position)

		
	else:
		look_at(get_global_mouse_position())
		

