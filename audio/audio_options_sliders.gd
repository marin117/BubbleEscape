extends HSlider

@export_category("Bus")
@export var bus_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _on_value_changed(volume_value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(volume_value))


func _on_music_slider_mouse_exited() -> void:
	release_focus()
