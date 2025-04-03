extends Node
class_name LevelStateSingletone

var active_debuffs: Dictionary[String, BaseDebuff] = {}

func reset():
	active_debuffs.clear()

func add_debuff(debuff: BaseDebuff):
	active_debuffs[debuff.name] = debuff

func get_debuff_or_null(debuff_type: String) -> BaseDebuff:
	return active_debuffs.get(debuff_type)
