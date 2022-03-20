extends Control

var allowed_characters = "[A-Za-z0-9]"

signal file_saved(file_name)
signal sub_menu_closed()

var file_name

onready var SaveFileButton = $ColorRect/VBoxContainer/SaveFileButton

onready var SaveFileNameEdit = $ColorRect/VBoxContainer/FileNameEdit

func _ready():
	SaveFileNameEdit.grab_focus()


func _on_SaveFileButton_pressed():
	emit_signal("file_saved",file_name)
	emit_signal("sub_menu_closed")
	queue_free()


func _on_CancelButton_pressed():
	emit_signal("sub_menu_closed")
	queue_free()


func _on_FileNameEdit_text_entered(new_text):
	SaveFileButton.disabled = false
	SaveFileButton.grab_focus()
	file_name = new_text
	

func _on_FileNameEdit_text_changed(new_text):
	var old_caret_position = SaveFileNameEdit.caret_position

	var word = ''
	var regex = RegEx.new()
	regex.compile(allowed_characters)
	for valid_character in regex.search_all(new_text):
		word += valid_character.get_string()
	SaveFileNameEdit.set_text(word)

	SaveFileNameEdit.caret_position = old_caret_position

