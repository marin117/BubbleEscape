extends Area2D

@export var hint: String = ""
@export var image_texture: String = ""

func _ready() -> void:
	if not image_texture.is_empty():
		$Sprite2D.texture = load(image_texture)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		$Hint.visible = true
		$Hint.text = hint


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		$Hint.visible = false
		$Hint.text = hint
