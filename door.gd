extends Area2D

signal door_opened

var time_passed : int = 0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		$AnimationPlayer.play("open")
		$OpenDoorTimer.start(1)

func _on_open_door_timer_timeout() -> void:
	$OpenDoorTimer.start(1)
	time_passed += 1
	if time_passed == 2:
		door_opened.emit()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		$OpenDoorTimer.stop()
		$AnimationPlayer.play("RESET")
		time_passed = 0
