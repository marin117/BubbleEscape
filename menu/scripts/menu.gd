extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://level/RootLevelScreen.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/OptionsMenu.tscn")
