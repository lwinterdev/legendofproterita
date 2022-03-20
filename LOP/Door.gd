extends StaticBody2D

var opening = false

onready var anim_player = $AnimationPlayer

func _physics_process(delta):
	if opening == true:
		position.y -= 1

func _on_TriggerArea_body_entered(body):
	if body.is_in_group("player") and opening == false:
		opening = true
		$DeathTimer.start()
		
	pass # Replace with function body.


func _on_DeathTimer_timeout():
	queue_free()
	pass # Replace with function body.
