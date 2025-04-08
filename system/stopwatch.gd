extends Node
class_name Stopwatch

@export var running: bool = true

var time_elapsed: float = 0.0
var time: String = ""

func _process(delta: float) -> void:
	if running:
		time_elapsed += delta

func formatted_time() -> String:
	var total_seconds := int(time_elapsed)
	@warning_ignore("integer_division")
	var hours: int = floor(total_seconds / 3600)
	@warning_ignore("integer_division")
	var minutes := (total_seconds % 3600) / 60
	var secs := total_seconds % 60
	var millis := int((time_elapsed - total_seconds) * 1000)
	return "%02d::%02d::%02d::%03d" % [hours, minutes, secs, millis]
