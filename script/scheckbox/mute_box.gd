extends CheckBox

@export var bus_name: String
var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	self.button_pressed = global.volume_mute[bus_index]
	connect("toggled", _on_Checkbox_toggled)

func _on_Checkbox_toggled(button_press: bool) -> void:
	global.volume_mute[bus_index] = button_press
	if button_press:
		AudioServer.set_bus_volume_db(
			bus_index,
			linear_to_db(0)
		)
	else:
		AudioServer.set_bus_volume_db(
			bus_index,
			linear_to_db(global.volume[bus_index])
		)
