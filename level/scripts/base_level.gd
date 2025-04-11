extends Node
class_name BaseLevel

@export_category("Next level")
@export var next_level: String

@export_category("Last level")
@export var last_level: bool = false

signal end_game
signal go_to_next_level

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("main_menu"):
		LevelState.go_to_main_menu()

func _on_door_opened() -> void:
	if last_level:
		end_game.emit()
		return
	go_to_next_level.emit()
