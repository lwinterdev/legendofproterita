extends Sprite

var falling_rock = preload("res://FallingRock.tscn")
onready var FallTimter = $FallTimer




func _on_FallTimer_timeout():
	var r = falling_rock.instance()
	add_child(r)
	pass # Replace with function body.
