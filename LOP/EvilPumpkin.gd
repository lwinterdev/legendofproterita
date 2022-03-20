signal removed
extends KinematicBody2D

var health = 10

var target 

export (int) var speed = 20

export (int) var base_speed = 10
export (int) var jump_speed = 10
export (int) var gravity = 0
export (int) var max_gravity = 0
var Floor = Vector2(0,0)
export (int) var melee_damage := 10

var velocity = Vector2.ZERO

export (float, 0, 1.0) var friction = 0.25
export (float, 0, 1.0) var acceleration = 0.1

var react_time := 5
var moving_left:= true
var moving

var next_direction = 0
var next_direction_time = 0  

var direction :int = 0

var target_distance:int = 20

var state = "idle"

onready var AnimPlayer = $AnimationPlayer

var minimap_icon = "enemy"

func _physics_process(delta):
	
	if moving:
		match direction:
			1:
				$Sprite.rotation += 0.1
			-1:
				$Sprite.rotation -= 0.1
		
	
	velocity.x = speed * direction

	velocity = move_and_slide(velocity,Floor)
	
	if target:

		if state == "chase":
			
			
			if target.position.x > position.x + target_distance and next_direction != 1 : #turn to right side 
				
				set_direction(1)
				$Sprite.flip_h = true
				moving = true
				
				
			elif target.position.x < position.x - target_distance  and next_direction != -1: #turn to left side
				
				set_direction(-1)
				$Sprite.flip_h = false
				moving = true
				
				
			
			elif target.position.x == position.x  and next_direction != 0:
				
				set_direction(0)
				moving = false
				
			
			if OS.get_ticks_msec() > next_direction_time:
				direction = next_direction
	if health <= 0:
		emit_signal("removed", self)
		queue_free()

func set_direction(new_direction):
	if next_direction != new_direction:
		next_direction = new_direction
		next_direction_time = OS.get_ticks_msec() + react_time
#		AnimPlayer.play("floating")
		


func _on_AggroArea_body_entered(body):
	if body.is_in_group("player"):
		target = body
		state = "chase"
	pass # Replace with function body.
	

func got_hit(recieved_damage):
	health -= recieved_damage
#	AnimPlayer.play("damage_flash")
	pass





