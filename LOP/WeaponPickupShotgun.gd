extends Area2D

var type = "shotgun"

var popup = preload("res://WeaponPickupPopup.tscn")

func _ready():
	if GlobalRoomHandler.weapon_shotgun == true:
		queue_free()


func _on_WeaponPickupShotgun_body_entered(body):
	if body.is_in_group("player"):
		var p = popup.instance()
		add_child(p)
		GlobalRoomHandler.weapon_shotgun = true
		body.add_weapon(type)
		GlobalMenuHandler.weapon_menu_active = true
		queue_free()
	pass # Replace with function body.
