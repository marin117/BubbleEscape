extends Node2D

@export var debuff : BaseDebuff

func _ready() -> void:
	LevelState.add_debuff(debuff)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "creep":
		$AnimationPlayer.play("blink")
