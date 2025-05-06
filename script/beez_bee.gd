extends Sprite2D

var rng = RandomNumberGenerator.new()

func updown() -> void:
	var wait = rng.randf_range(0.7, 1.4)
	var tween1 = create_tween()
	tween1.tween_property(self, "position", Vector2(rng.randf_range(-7, 7), rng.randf_range(-14, 14)), wait).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	var tween2 = create_tween()
	tween2.tween_property(self, "rotation_degrees", rng.randf_range(80, 100), wait).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await get_tree().create_timer(wait).timeout
	#wait = rng.randf_range(0.7, 1.4)
	#var tween3 = create_tween()
	#tween3.tween_property(self, "position:y", Vector2(10, 10), wait)
	#await get_tree().create_timer(wait)
	updown()

func _ready() -> void:
	updown()
	pass
