extends Control

@export var stopwatch_node: Stopwatch

@onready var stopwatch: Label = $VBoxContainer/StopwatchLabel

func _process(_delta: float) -> void:
	stopwatch.text = stopwatch_node.formatted_time()
