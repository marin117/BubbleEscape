extends Node
class_name LevelStateSingletone

var active_debuffs: Dictionary[String, BaseDebuff] = {}
var time_elapsed: float = 0.0

func reset():
	active_debuffs.clear()

func add_debuff(debuff: BaseDebuff):
	active_debuffs[debuff.name] = debuff

func get_debuff_or_null(debuff_type: String) -> BaseDebuff:
	return active_debuffs.get(debuff_type)

func go_to_main_menu() -> void:
	reset()
	get_tree().change_scene_to_file("res://menu/Menu.tscn")

func go_to_end_game() -> void:
	reset()
	get_tree().change_scene_to_file("res://menu/EndGame.tscn")
