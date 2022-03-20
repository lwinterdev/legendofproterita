extends Node2D


var save_path

var save_and_load_activated = false

var player

var player_spawn_position

var level

var password = "123"


func save_room(level,save_path,player):
	self.level = level
	self.save_path = save_path
	self.player = player
	
	var config = ConfigFile.new()

#save player
	config.set_value("player", "position", player_spawn_position)
#	config.set_value("player", "health", player.health)

#save enemies
	var enemies = []
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemies.push_back({
			position = enemy.position,
			health = enemy.health
		})
	config.set_value("enemies", "enemies", enemies)
	
#save checkpoints
	var checkpoints = []
	for checkpoint in get_tree().get_nodes_in_group("checkpoint"):
		checkpoints.push_back({
			position = checkpoint.position
		})
	config.set_value("checkpoints", "checkpoints", checkpoints)

	config.save_encrypted_pass(save_path,password)
	

func load_room(level,save_path,player):
	self.level = level
	self.save_path = save_path
	self.player = player
	
#	get_tree().paused = true
	var config = ConfigFile.new()
	var err = config.load_encrypted_pass(save_path,password)
	if err != OK:
		print("file not found")
		return
	
	player.global_position = config.get_value("player", "position")
	player.health = config.get_value("player", "health")

	# Remove existing enemies and add new ones.
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.queue_free()

	var enemies = config.get_value("enemies", "enemies")
	

	for enemy_config in enemies:
		var enemy = preload("res://EnemyClass.tscn").instance()
		enemy.position = enemy_config.position
		enemy.health = enemy_config.health
		level.add_child(enemy)
		
		
	for checkpoint in get_tree().get_nodes_in_group("checkpoint"):
		checkpoint.queue_free()

	var checkpoints = config.get_value("checkpoints" , "checkpoints")
	

	for checkpoint_config in checkpoints:
		var checkpoint = preload("res://CheckPoint.tscn").instance()
		checkpoint.position = checkpoint_config.position
		level.add_child(checkpoint)

