extends Area2D

@export var hint: String = ""

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		$Hint.visible = true
		$Hint.text = hint


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		$Hint.visible = false
		$Hint.text = hint
