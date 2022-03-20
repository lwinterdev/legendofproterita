extends Sprite

func _physics_process(delta):
	look_at(get_global_mouse_position())
	
#	if get_global_mouse_position().x > global_position.x :
#		flip_h = true
#	else:
#		flip_h = false
