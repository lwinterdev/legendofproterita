extends StaticBody2D

onready var talk_bubble = $TalkBubble
onready var anim_player = $AnimationPlayer

var talkable = false
var talking = false

func _ready():
	anim_player.play("blink")

func _physics_process(delta):
	if talkable == true:
		talk_bubble.visible = true
	else:
		talk_bubble.visible = false
	
	if Input.is_action_just_pressed("interact") and talking == false:
		var porcellina_talking = Dialogic.start("porcellina_talking")
		add_child(porcellina_talking)
		talking = true
		$TalkTimer.start()

func _on_TalkArea_body_entered(body):
	talkable = true
	
	pass # Replace with function body.



func _on_TalkArea_body_exited(body):
	talkable = false
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "blink":
		anim_player.play("blink")
	pass # Replace with function body.


func _on_TalkTimer_timeout():
	talking = false
	pass # Replace with function body.
