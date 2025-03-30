extends Node2D

@export_category("Item Type")
@export var bubbles: PackedScene

@export var max_size : int = 4

var size_debuff : bool = false

func spawn_at(bubble_position: Vector2) -> void:
	if get_child_count() >= max_size:
		remove_at(0)
	var bubble = bubbles.instantiate()
	bubble.enlarge()
	bubble.position = bubble_position
	if size_debuff:
		bubble.bubble_burst_limit = 0.3
	bubble.bubble_burst.connect(_on_bubble_burst)
	bubble.bubble_collided.connect(_on_bubble_collided)
	add_child(bubble)

func set_size_debuff(debuff: bool) -> void:
	# TODO: Remove this
	size_debuff = debuff

func remove_at(index: int) -> void:
	var item : Node2D = get_child(index)
	if item:
		AudioManager.play_pop()
		item.queue_free()

func stop_spawning() -> void:
	if get_child_count() == 0:
		return
	var last_bubble = get_child(get_child_count() - 1)
	if last_bubble:
		last_bubble.stop_enlarging()

func _on_bubble_burst() -> void:
	if get_child_count():
		remove_at(get_child_count() - 1)

func _on_bubble_collided(bubble: Node2D) -> void:
	var last_bubble = get_child(get_child_count() - 1)
	if bubble != last_bubble:
		remove_at(bubble.get_index())
