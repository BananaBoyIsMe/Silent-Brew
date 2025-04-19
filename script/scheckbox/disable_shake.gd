extends CheckBox

@export var global_index: int

func _ready() -> void:
	self.button_pressed = global.volume_mute[global_index]
	connect("toggled", _on_Checkbox_toggled)

func _on_Checkbox_toggled(button_press: bool) -> void:
	global.volume_mute[global_index] = button_press
	#print(global.volume_mute[global_index])
