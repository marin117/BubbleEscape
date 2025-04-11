extends Node2D

@onready var stopwatch_label: Label = $MarginContainer/VBoxContainer/StopwatchLabel

func _ready() -> void:
	stopwatch_label.text = TimeUtils.format_time(LevelState.time_elapsed)
