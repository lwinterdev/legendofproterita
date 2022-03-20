extends Node2D

onready var Tip = $Tip
var direction := Vector2(0,0)
var tip := Vector2(0,0)

var speed = 10

var is_flying = false
var is_hooked = false

func shoot(dir: Vector2):
	direction = dir.normalized()
	is_flying = true
	tip = self.global_position
	
func release():
	is_flying = false
	is_hooked = false


	

