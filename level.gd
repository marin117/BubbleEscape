extends Node2D
class_name Level

const Types = preload( "res://Types.gd")

@export var bubble_scene: PackedScene
@export var next_level: String
# Called when the node enters the scene tree for the first time.
var _player_action_hold: bool = false

var bubbles: Array = []
var creeper_debuff: bool = false

var max_bubbles: int = 4

func _ready() -> void:
	if get_node_or_null("Creeper"):
		creeper_debuff = true

func _spawn_bubble():

	if bubbles.size() == max_bubbles:
		_burst_bubble_at(0)
	var bubble = bubble_scene.instantiate()
	bubble.position = $Player.weapon_marker_position
	bubbles.append(bubble)
	if creeper_debuff:
		bubble.bubble_burst_limit = 0.3
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
		_burst_bubble_at(index)

func _on_bubble_burst() -> void:
	_burst_bubble_at(-1)

func _burst_bubble_at(index: int) -> void:
	if index > bubbles.size():
		return
	index = max(-1, index)
	AudioManager.play_pop()
	bubbles[index].queue_free()
	if index < 0:
		bubbles.resize(bubbles.size() - 1)
	else:
		bubbles.remove_at(index)

func _on_door_opened() -> void:
	get_tree().change_scene_to_file(next_level)


func _on_soap_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		body.set_sliding(true)


func _on_soap_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		body.set_sliding(false)


func _on_player_player_dropped() -> void:
	$Player.global_position = $StartingPosition.global_position


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu.tscn")
