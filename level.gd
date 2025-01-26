extends Node2D
class_name Level

const Types = preload( "res://Types.gd")

@export var bubble_scene: PackedScene
@export var next_level: String
# Called when the node enters the scene tree for the first time.
var _player_action_hold: bool = false

var bubbles: Array = []

var max_bubbles: int = 4

func _spawn_bubble():

	if bubbles.size() == max_bubbles:
		bubbles[0].queue_free()
		bubbles.remove_at(0)
	var bubble = bubble_scene.instantiate()
	bubble.position = $Player.weapon_marker_position
	bubbles.append(bubble)
	bubble.enlarge()
	bubble.bubble_collided.connect(_on_bubble_collided)
	bubble.bubble_burst.connect(_on_bubble_burst)
	$Bubbles.add_child(bubble)

func _on_player_action_pressed() -> void:
	if not _player_action_hold:
		_player_action_hold = true
		_spawn_bubble()

func _on_player_action_released() -> void:
	_player_action_hold = false
	if not bubbles.is_empty():
		bubbles[-1].stop_enlarging()

func _on_bubble_collided(bubble: Node2D) -> void:
	var to_remove: Array[int] = []
	for index in bubbles.size():
		if bubbles[index] == bubble  && bubble != bubbles[-1]:
			to_remove.append(index)
	for index in to_remove:
		bubbles[index].queue_free()
		bubbles.remove_at(index)

func _on_bubble_burst() -> void:
	bubbles[-1].queue_free()
	bubbles.resize(bubbles.size() - 1)

func _on_door_opened() -> void:
	get_tree().change_scene_to_file(next_level)


func _on_soap_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		body.set_sliding(true)


func _on_soap_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		body.set_sliding(false)
