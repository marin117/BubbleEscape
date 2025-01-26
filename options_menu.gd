extends Control

func _on_back_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Menu.tscn")


func _on_confirm_pressed() -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db($AudioOptions/MarginContainer/VBoxContainer/MusicSlider.value))
	AudioServer.set_bus_volume_db(2, linear_to_db($AudioOptions/MarginContainer/VBoxContainer/SFXSlider.value))
