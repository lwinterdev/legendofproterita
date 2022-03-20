extends Control

signal submenu_closed

onready var GeneralVolumeSlider = $ColorRect/CenterContainer/VBoxContainer/HBoxContainer/GeneralVolumeSlider
onready var GeneralVolumeLabel = $ColorRect/CenterContainer/VBoxContainer/HBoxContainer/GenralVolumeLabel

onready var GeneralSoundsSlider = $ColorRect/CenterContainer/VBoxContainer/HBoxContainer2/SoundsVolumeSlider
onready var GeneralSoundsLabel = $ColorRect/CenterContainer/VBoxContainer/HBoxContainer2/SoundsLabel

onready var BackgroundMusicLabel = $ColorRect/CenterContainer/VBoxContainer/HBoxContainer3/BackGroundVolumeLabel
onready var BackgroundMusicSlider = $ColorRect/CenterContainer/VBoxContainer/HBoxContainer3/BackgroundMusicVolumeSlider

onready var TestAudioStrem = $TestAudioStream
onready var TestSoundStream = $TestSoundStream

var general_volume
var bgmusic_volume
var sounds_volume

func _ready():
	GeneralVolumeSlider.grab_focus()
	general_volume = TestAudioStrem.volume_db
	GeneralVolumeSlider.value = general_volume
	
	sounds_volume = TestSoundStream.volume_db
	GeneralSoundsSlider.value = sounds_volume
	
	bgmusic_volume = 0
	
func _physics_process(_delta):

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), general_volume)
	GeneralVolumeLabel.text = str(general_volume+80)
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), sounds_volume)
	GeneralSoundsLabel.text = str(sounds_volume+80)
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Background Music"), bgmusic_volume)
	BackgroundMusicLabel.text = str(bgmusic_volume+80)
	

func _on_GeneralVolumeSlider_value_changed(value):
	general_volume = value
	pass # Replace with function body.


func _on_AudioOptionsBackButton_pressed():
	GlobalMenuHandler.option_menu_active = true
	emit_signal("submenu_closed")
	queue_free()
	pass # Replace with function body.


func _on_VolumeTestButton_pressed():
	TestAudioStrem.stop()
	TestAudioStrem.play()
	pass # Replace with function body.


func _on_SoundsVolumeSlider_value_changed(value):
	sounds_volume = value
	pass # Replace with function body.


func _on_VolumeTestButton2_pressed():
	TestSoundStream.stop()
	TestSoundStream.play()
	pass # Replace with function body.


func _on_AudioOptionsMenuResetButton_pressed():
	general_volume = 0
	sounds_volume = 0
	bgmusic_volume = 0
	GeneralVolumeSlider.value = general_volume
	GeneralSoundsSlider.value = sounds_volume
	BackgroundMusicSlider.value = bgmusic_volume
	TestSoundStream.stop()
	TestAudioStrem.stop()
	pass # Replace with function body.


func _on_BackgroundMusicVolumeSlider_value_changed(value):
	bgmusic_volume = value
	pass # Replace with function body.
