signal removed
extends KinematicBody2D

var health = 100

onready var AnimPlayer = $AnimationPlayer

var Bee = preload("res://MandelForestBee.tscn")

var minimap_icon = "door"

func _physics_process(delta):
	if health <= 0:
		death()

func got_hit(recieved_damage):
	health -= recieved_damage
	AnimPlayer.play("damage_flash")
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "damage_flash":
		AnimPlayer.play("RESET")
	pass # Replace with function body.

func death():
	randomize()
	
	for i in range(1,5):
		
		var rand_x = randi() % 20
		var rand_y = randi() % 20
			
		var b = Bee.instance()
		b.global_position.x = position.x + rand_x * 2
		b.global_position.y = position.y + rand_y * 2
		get_parent().add_child(b)
	emit_signal("removed", self)
	queue_free()
	pass
