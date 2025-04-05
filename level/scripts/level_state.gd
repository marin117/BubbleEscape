extends Node
class_name LevelStateSingletone

var active_debuffs: Dictionary[String, BaseDebuff] = {}

const root_level_node_name: String = "RootLevel"

func reset():
	active_debuffs.clear()

func add_debuff(debuff: BaseDebuff):
	active_debuffs[debuff.name] = debuff

func get_debuff_or_null(debuff_type: String) -> BaseDebuff:
	return active_debuffs.get(debuff_type)

func go_to_next_level(next_level_path: String) -> void:
	_change_levels_deffered.call_deferred(next_level_path)

func go_to_main_menu() -> void:
	reset()
	get_tree().change_scene_to_file("res://menu/Menu.tscn")

func _change_levels_deffered(next_level_path: String) -> void:
	reset()
	var root_level: Node = get_tree().root.get_node(root_level_node_name)
	_free_current_level()
	var next_level_scene := ResourceLoader.load(next_level_path)
	var next_level: BaseLevel = next_level_scene.instantiate()
	root_level.add_child(next_level)

func _free_current_level() -> void:
	var root_level: Node = get_tree().root.get_node(root_level_node_name)
	var current_level := root_level.get_child(-1)
	if current_level:
		current_level.free()
