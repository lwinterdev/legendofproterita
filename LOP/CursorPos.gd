extends Position2D



export (int) var speed = 200

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		position.x += 1
	if Input.is_action_pressed("move_left"):
		position.x -= 1
	if Input.is_action_pressed("down"):
		position.y += 1
	if Input.is_action_pressed("up"):
		position.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	
