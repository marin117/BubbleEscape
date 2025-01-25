extends CharacterBody2D

const FALL_VELOCITY: float = 0.1
const BOUNCE_STRENGTH = 0.5

signal bubble_collided(body: Node2D)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
