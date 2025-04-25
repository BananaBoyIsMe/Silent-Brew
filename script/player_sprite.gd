extends Sprite2D

func dance() -> void:
	if global.move_now:
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", 7, 0.2)
		await tween.finished
		var tween1 = create_tween()
		tween1.tween_property(self, "rotation_degrees", -7, 0.25)
		await tween1.finished
	var tween2 = create_tween()
	tween2.tween_property(self, "rotation_degrees", 0, 0.1)
	await get_tree().create_timer(0.1).timeout
	dance()

func _ready() -> void:
	dance()
