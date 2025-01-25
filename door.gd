extends Area2D

signal door_opened

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		$AnimationPlayer.play("open")
		$OpenDoorTimer.start(3)

func _on_open_door_timer_timeout() -> void:
	door_opened.emit()
