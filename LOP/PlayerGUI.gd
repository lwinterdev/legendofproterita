extends Control

onready var FpsValueTag = $HBoxContainer/FpsValue
onready var MemoryValueTag = $HBoxContainer2/MemoryValue

onready var WeaponMenu =$CenterContainer/WeaponMenu

onready var Key1 = $ItemIcons/Key1
onready var SpawnHouseKey = $ItemIcons/SpawnHouseKey

func _ready():
	
	GlobalMenuHandler.weapon_menu_active = true
	WeaponMenu.visible = false

func _physics_process(delta):
	FpsValueTag.text = str(Performance.get_monitor(Performance.TIME_FPS))
	MemoryValueTag.text = str(Performance.get_monitor(Performance.MEMORY_STATIC))
	
	if GlobalRoomHandler.key1 == false:
		Key1.visible = false
	else:
		Key1.visible = true
		
	SpawnHouseKey.visible = GlobalRoomHandler.spawn_house_key
	
	if Input.is_action_just_pressed("toggle_weapon_menu") and GlobalMenuHandler.weapon_menu_active:
		if WeaponMenu.visible == false:
			GlobalMenuHandler.pause_menu_active = false
			WeaponMenu.visible = true
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
			
			for w in WeaponMenu.get_children():
				w.grab_focus()
#				w.connect("weapon_selected",self,"weapon_selected")
				return
		else:
			WeaponMenu.visible = false
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			GlobalMenuHandler.pause_menu_active = true

func weapon_selected():
	WeaponMenu.visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	GlobalMenuHandler.pause_menu_active = true

