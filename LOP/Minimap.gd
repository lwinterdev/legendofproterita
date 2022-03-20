extends MarginContainer

export (NodePath) var player

export var zoom = 0.25

onready var Grid = $MarginContainer/Grid
onready var PlayerMarker = $MarginContainer/Grid/PlayerMarker
onready var EnemyMarker = $MarginContainer/Grid/EnemyMarker
onready var DoorMarker = $MarginContainer/Grid/AlertMarker

onready var icons = {"door" : DoorMarker , "enemy" : EnemyMarker, "player": PlayerMarker}

var grid_scale
var markers = {}

func _ready():
	visible = false
	grid_scale = Grid.rect_size/ (get_viewport_rect().size * zoom)
	
	var map_objects = get_tree().get_nodes_in_group("minimap_objects")
	for item in map_objects:
		var new_marker = icons[item.minimap_icon].duplicate()
		Grid.add_child(new_marker)
		new_marker.show()
		markers[item] = new_marker
		

func _physics_process(delta):
	if Input.is_action_just_released("toggle_map"):
		visible = !visible
	
	if !player:
		return
		
	for item in markers:
		var obj_pos = (item.position - Vector2(0,0)) * grid_scale + Grid.rect_size / 2
		obj_pos.x = clamp(obj_pos.x, 0, Grid.rect_size.x)
		obj_pos.y = clamp(obj_pos.y, 0, Grid.rect_size.y)
		markers[item].position = obj_pos
		pass
	

func _on_object_removed(object):
	if object in markers:
		markers[object].queue_free()
		markers.erase(object)
