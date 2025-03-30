extends CharacterBody2D

const FALL_VELOCITY: float = 0.05
const BOUNCE_STRENGTH: float = 0.5

@export var bubble_burst_limit: float = 0.95
var bursting: bool = false

signal bubble_collided(body: Node2D)
signal bubble_burst()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scale.x > bubble_burst_limit:
		bubble_burst.emit()
	if not is_on_floor():
		velocity += FALL_VELOCITY * get_gravity() * delta
	var collision_info: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal()) * BOUNCE_STRENGTH

func enlarge() -> void:
	$AnimationPlayer.play("spawn")

func stop_enlarging() -> void:
	$AnimationPlayer.stop(true)

func _on_bubble_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("bubbles") and body != self:
		bubble_collided.emit(body)
