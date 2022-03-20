extends KinematicBody2D

var speed = 50

var gravity = 132

var velocity = Vector2.ZERO
var is_jumping := false
var is_falling := false

var react_time := 100
var moving_left:= true

var next_direction = 0
var next_direction_time = 0  

var direction :int = 0

var target_distance:int = 200

var state = "idle"

var target

func _ready():
	pass
	
func _physics_process(delta):
	velocity.y += gravity
	
	velocity.x = speed * direction
	velocity = move_and_slide(velocity)
	
	if target:
		
		if state == "chase":
				
			if target.position.x > position.x:
				direction = 1
			if target.position.x < position.x:
				direction = -1
	
func set_direction(new_direction):
	if next_direction != new_direction:
		next_direction = new_direction
		next_direction_time = OS.get_ticks_msec() + react_time
	pass

func _on_AggroArea_body_entered(body):
	if body.is_in_group("player"):
		target = body
		state = "chase"
	pass # Replace with function body.
