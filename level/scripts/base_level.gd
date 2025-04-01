extends Node
class_name BaseLevel
@export var next_level: String

func _change_scene_to(scene: String) -> void:
	LevelState.reset()
	get_tree().change_scene_to_file(scene)

func _on_main_menu_pressed() -> void:
	_change_scene_to("res://menu/Menu.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("main_menu"):
		_change_scene_to("res://menu/Menu.tscn")

func _on_door_opened() -> void:
	_change_scene_to(next_level)
