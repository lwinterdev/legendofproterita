extends Node2D

onready var player = $TileMap/Player
onready var tm = $TileMap


func _ready():
	OS.window_fullscreen = true
