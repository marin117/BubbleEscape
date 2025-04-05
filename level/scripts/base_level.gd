extends Node
class_name BaseLevel
@export var next_level: String

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("main_menu"):
		LevelState.go_to_main_menu()

func _on_door_opened() -> void:
	LevelState.go_to_next_level(next_level)
