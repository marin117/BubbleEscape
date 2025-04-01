extends Node
class_name LevelStateSingletone

var active_debuffs: Array[BaseDebuff] = [] 

func reset():
	active_debuffs.clear()

func add_debuff(debuff: BaseDebuff):
	active_debuffs.append(debuff)

func get_debuff_or_null(debuff_type: String) -> BaseDebuff:
	for debuff in active_debuffs:
		if debuff.name == debuff_type:
			return debuff
	return null

func apply_debuffs_to(target):
	for debuff in active_debuffs:
		debuff.apply_effect(target)
