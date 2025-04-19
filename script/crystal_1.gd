extends Node2D

var rng = RandomNumberGenerator.new()
var original_modulate

func _ready() -> void:
	original_modulate = self.modulate
	crystal()
	

func crystal() -> void:
	match rng.randi_range(1, 3):
		1:
			var time_change = rng.randf_range(1.5, 3)
			var tween1 = create_tween()
			tween1.tween_property(self, "modulate", original_modulate + Color(rng.randf_range(0.1, 0.2), rng.randf_range(0.1, 0.2), rng.randf_range(0.1, 0.2)), time_change)
			await get_tree().create_timer(time_change).timeout
			var tween2 = create_tween()
			tween2.tween_property(self, "modulate", original_modulate, time_change)
	await get_tree().create_timer(3).timeout
	crystal()
