extends Node

@onready var stopwatch: Stopwatch = $Stopwatch

var active_level: BaseLevel

func go_to_next_level() -> void:
	_change_levels_deffered.call_deferred(active_level.next_level)

func _on_end_game() -> void:
	stopwatch.stop()
	LevelState.time_elapsed = stopwatch.time_elapsed
	LevelState.go_to_end_game()

func _on_child_entered_tree(node: Node) -> void:
	if node is BaseLevel:
		active_level = get_child(-1)
		active_level.connect("end_game", _on_end_game)
		active_level.connect("go_to_next_level", go_to_next_level)

func _on_child_exiting_tree(node: Node) -> void:
	if node is BaseLevel:
		active_level.disconnect("end_game", _on_end_game)
		active_level.disconnect("go_to_next_level", go_to_next_level)

func _change_levels_deffered(next_level_path: String) -> void:
	LevelState.reset()
	_free_current_level()
	if next_level_path.is_empty():
		return
	var next_level_scene := ResourceLoader.load(next_level_path)
	var next_level: BaseLevel = next_level_scene.instantiate()
	add_child(next_level)

func _free_current_level() -> void:
	var current_level := get_child(-1)
	if current_level:
		current_level.free()
