extends Sprite

func _physics_process(delta):
	modulate.a -= 0.1

func _on_FadeTimer_timeout():
	queue_free()
	pass # Replace with function body.
