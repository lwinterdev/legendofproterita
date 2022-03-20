extends Sprite

var speed = 5

func _physics_process(delta):
	if Input.is_action_pressed("aim_down"):
		position.y += speed
	if Input.is_action_pressed("aim_up"):
		position.y -= speed
	if Input.is_action_pressed("aim_right"):
		position.x += speed
	if Input.is_action_pressed("aim_left"):
		position.x -= speed
	if GlobalControlsHandler.controller_active == true:
		Input.warp_mouse_position(self.position)
	else:
		global_position = get_global_mouse_position()
	pass
