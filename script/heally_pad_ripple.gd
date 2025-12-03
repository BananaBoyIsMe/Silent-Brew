extends Sprite2D

var rng = RandomNumberGenerator.new()
var base_pos : Vector2

func _ready() -> void:
	base_pos = position
	loop()

func loop() -> void:
	var new_pos = base_pos + Vector2(rng.randf_range(-6, 6), rng.randf_range(-6, 6))
	var tween = create_tween()
	tween.tween_property(self, "position", new_pos, rng.randf_range(2, 5)).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await tween.finished
	#new_pos = base_pos + Vector2(rng.randf_range(-6, 6), rng.randf_range(-6, 6))
	#var tween1 = create_tween()
	#tween1.tween_property(self, "position", new_pos, rng.randf_range(0.5, 2)).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	#await tween.finished
	loop()
