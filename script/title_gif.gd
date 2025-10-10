extends Sprite2D

func _ready() -> void:
	global.connect("in_game_toggled", _in_game_toggled)

func _in_game_toggled(state:bool) -> void:
	match state:
		true:
			#print("Gone")
			var tween = create_tween()
			tween.tween_property(self, "modulate:a", 0, 1)
		false:
			await get_tree().create_timer(1).timeout
			var tween = create_tween()
			tween.tween_property(self, "modulate:a", 1, 1)
