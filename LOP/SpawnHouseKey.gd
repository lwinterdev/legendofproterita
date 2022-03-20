extends Area2D

onready var AnimPlayer = $AnimationPlayer

func _ready():
	if GlobalRoomHandler.spawn_house_key == true:
		queue_free()


func _on_SpawnHouseKey_body_entered(body):
	if body.is_in_group("player"):
		GlobalRoomHandler.spawn_house_key = true
		queue_free()

