extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/VBoxContainer/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$MarginContainer/VBoxContainer/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))

func _on_music_slider_mouse_exited() -> void:
	release_focus()


func _on_sfx_slider_mouse_exited() -> void:
	release_focus()
