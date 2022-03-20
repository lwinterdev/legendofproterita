extends Sprite

func _physics_process(delta):
	modulate.a -= 0.02


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
