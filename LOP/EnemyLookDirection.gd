extends Node2D

func save():
	var save_dict = {
		"pos_x" : position.x,
		"pos_y" : position.y,
		
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		
		
	
		
		
		
		}
		
	return save_dict
