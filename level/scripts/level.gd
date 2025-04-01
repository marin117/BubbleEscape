extends BaseLevel
class_name Level

const Types = preload( "res://utils/types.gd")
const Player = preload("res://player/player.gd")

@export var bubble_scene: PackedScene
@export var level_debuffs : Array[BaseDebuff]
# Called when the node enters the scene tree for the first time.
var _player_action_hold: bool = false

@onready var player : Player = $Player
@onready var bubbles : Node2D = $Bubbles
var player_starting_position : Node2D

var creeper_debuff: bool = false

func _ready() -> void:
	if get_node_or_null("StartingPosition"):
		player_starting_position = $StartingPosition

func _process(_delta: float) -> void:
	super(_delta)

func _on_player_action_pressed() -> void:
	if not _player_action_hold:
		_player_action_hold = true
		bubbles.spawn_at(player.weapon_marker_position)

func _on_player_action_released() -> void:
	_player_action_hold = false
	bubbles.stop_spawning()

func _on_soap_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		body.set_sliding(true)

func _on_soap_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		body.set_sliding(false)

func _on_player_dropped() -> void:
	if player_starting_position:
		player.global_position = player_starting_position.global_position
