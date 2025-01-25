extends CharacterBody2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -400.0

signal action_pressed
signal action_released
signal player_jump

const Types = preload( "res://Types.gd")
const Bubble = preload( "res://bubble.gd")


@export var state : Types.PlayerStates = Types.PlayerStates.IDLE
@export var flipped: int = 1

func _apply_forces(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func _physics_process(delta: float) -> void:
	# Add the gravity.
	_apply_forces(delta)

	if is_on_floor():
		state = Types.PlayerStates.IDLE
	else:
		state = Types.PlayerStates.JUMPING

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		player_jump.emit()
	
	if Input.is_action_just_pressed("action"):
		action_pressed.emit()
	if Input.is_action_just_released("action"):
		action_released.emit()

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if direction == -1:
			$Sprite2D.flip_h = true
			flipped = -1 
		else:
			$Sprite2D.flip_h = false
			flipped = 1
		if is_on_floor():
			state = Types.PlayerStates.WALKING
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	_change_animation()
	move_and_slide()

func _change_animation() -> void:
	if state == Types.PlayerStates.JUMPING:
		$AnimationPlayer.play("jumping")
		return
	if is_on_floor() and state == Types.PlayerStates.WALKING:
		$AnimationPlayer.play("walking")
		return
	$AnimationPlayer.play("idle")
