extends StaticBody2D

onready var AnimPlayer = $AnimationPlayer

var Dissolve = preload("res://PurpleWallDestructableDissolve.tscn")

var health = 10

func _physics_process(delta):
	if health <= 0:
		var d = Dissolve.instance()
		d.position = position
		get_parent().add_child(d)
		queue_free()
		
func got_hit(recieved_damage):
	health -= recieved_damage
	AnimPlayer.play("damage_flash")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "damage_flash":
		AnimPlayer.play("RESET")
	pass # Replace with function body.
