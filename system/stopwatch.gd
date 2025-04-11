extends Node
class_name Stopwatch

@export var running: bool = true

var time_elapsed: float = 0.0
var time: String = ""

func _process(delta: float) -> void:
	if running:
		time_elapsed += delta

func formatted_time() -> String:
	return TimeUtils.format_time(time_elapsed)

func stop() -> void:
	running = false
