extends ColorRect

func _ready():
	visible = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "SceneTranstion":
		visible = false
		$AnimationPlayer.stop()
	pass # Replace with function body.

func play_scene_transition_animation():
	$AnimationPlayer.play_backwards("SceneTransition")

func play_scene_transition_reversed():
	$AnimationPlayer.play("SceneTransition")
