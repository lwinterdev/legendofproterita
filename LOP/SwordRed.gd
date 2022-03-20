extends Area2D

onready var weapon_sprite = $AnimatedSprite

func _ready():
	weapon_sprite.play("swing")

func _on_AnimatedSprite_animation_finished():
	queue_free()
	pass # Replace with function body.
