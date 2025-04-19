extends HSlider

@export var bus_name: String
var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	self.value = global.volume[bus_index]
	value_changed.connect(_on_volume_changed)

func _on_volume_changed(values: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(values)
	)
	global.volume[bus_index] = values
	#print(bus_index)
	#print(linear_to_db(values))
