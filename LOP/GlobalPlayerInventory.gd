extends Node

var player

var save_path = "user://player_inventory.ini"

var time_played

var time_start = 0
var time_now = 0

var measuring_time 

func start_play_timer():
	time_start = OS.get_unix_time()
	measuring_time = true

func stop_play_timer():
	measuring_time = false

func _process(delta):
	if measuring_time:
		time_now = OS.get_unix_time()
		var elapsed = time_now - time_start
		var minutes = elapsed / 60
		var seconds = elapsed % 60
		var elapsed_time= "%02d : %02d" % [minutes, seconds]
		time_played = str(elapsed_time)


func save_inventory():
	var config = ConfigFile.new()
	
	#save weapons
	var weapons = []
	for weapon in get_tree().get_nodes_in_group("weapon"):
		weapons.push_back({
			type = weapon.type
		})
	config.set_value("weapons", "weapons", weapons)
	config.save(save_path)
	
	
func load_inventory():
	var config = ConfigFile.new()
	var err = config.load(save_path)
	if err != OK:
		return
		

	for weapon in get_tree().get_nodes_in_group("weapon"):
		weapon.queue_free()

	var weapons = config.get_value("weapons", "weapons")
	

	for weapon_config in weapons:
		var weapon = preload("res://WeaponSlotButton.tscn").instance()
		weapon.type = weapon_config.type
		print(weapon.type)
		player.add_weapon(weapon.type)
	
