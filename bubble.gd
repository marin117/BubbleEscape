extends CharacterBody2D

const FALL_VELOCITY: float = 10.0

signal bubble_collided(body: Node2D)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y = FALL_VELOCITY
		velocity += get_gravity() * delta
	move_and_slide()

func enlarge():
	$AnimationPlayer.play("spawn")

func stop_enlarging():
	$AnimationPlayer.stop(true)

func _on_bubble_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("bubbles") and body != self:
		bubble_collided.emit(body)
		
