extends Sprite

var flying = false
var sprite_captured = preload("res://Sprites/cat_getting_captured.png")
onready var anim_player = $AnimationPlayer

func _physics_process(delta):
	if flying == true:
		texture = sprite_captured
		position.y -= 0.75

func _on_TriggerArea_body_entered(body):
	if body.is_in_group("player"):
		flying = true
	pass # Replace with function body.
