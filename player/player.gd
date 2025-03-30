extends CharacterBody2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -400.0

signal action_pressed
signal action_released
signal player_jump
signal player_dropped

const Types = preload("res://utils/types.gd")
const Bubble = preload( "res://bubble/bubble.gd")

var sliding: bool = false

var input_disabled: bool = false

@export var state : Types.PlayerStates = Types.PlayerStates.IDLE
@export var weapon_marker_position: Vector2 = Vector2(0,0)

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
	_handle_input()
	_handle_mouse_rotation(get_global_mouse_position())
	weapon_marker_position = $Weapon/WeaponMarker.global_position
	_change_animation()
	move_and_slide()

func _handle_input() -> void:
	if input_disabled:
		return
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
		if is_on_floor():
			state = Types.PlayerStates.WALKING
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if sliding:
		velocity *= 1.2

func _handle_mouse_rotation(mouse_pos : Vector2) -> void:
	var angle_to_mouse: float = rad_to_deg((mouse_pos - $Weapon.global_position).normalized().angle())
	if angle_to_mouse < 0:
		angle_to_mouse += 360
	if ((angle_to_mouse < 20 or angle_to_mouse > 160) and
		(angle_to_mouse < 240 or angle_to_mouse > 300)):
		$Body.flip_h = position > mouse_pos
		$Hands.flip_v = position > mouse_pos
		$Weapon.look_at(mouse_pos)
		$Hands.look_at(mouse_pos)

func _change_animation() -> void:
	if state == Types.PlayerStates.JUMPING:
		$AnimationPlayer.play("jumping")
		return
	if is_on_floor() and state == Types.PlayerStates.WALKING:
		$AnimationPlayer.play("walking")
		return
	$AnimationPlayer.play("idle")

func set_sliding(value: bool) -> void:
	sliding = value

func disable_input() -> void:
	input_disabled = false


func _on_screen_notifier_screen_exited() -> void:
	player_dropped.emit()
