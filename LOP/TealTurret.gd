extends KinematicBody2D

onready var Head = $Head
onready var RayC = $Head/RayCast2D
onready var AnimPlayer = $AnimationPlayer

var bullet = preload("res://TealTurretBullet.tscn")

var can_fire:bool = false

var target 

func _physics_process(delta):
	if target:
		Head.look_at(target.position)
	if can_fire == true:
		AnimPlayer.play("attack_flash")
		can_fire = false


func _on_AggroArea_body_entered(body):
	if body.is_in_group("player"):
		target = body
		if can_fire == false:
			can_fire = true
	pass # Replace with function body.


func _on_Shield_body_entered(body):
	if body.is_in_group("bullet"):
		body.queue_free()
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack_flash":
		AnimPlayer.play("recovery_flash")
		var b = bullet.instance()
		
		b.transform = Head.transform
		b.position = $Head/Blink.global_position
		
		get_parent().add_child(b)
	if anim_name == "recovery_flash":
		can_fire = true
	pass # Replace with function body.
