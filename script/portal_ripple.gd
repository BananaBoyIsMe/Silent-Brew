extends Node2D

var rng = RandomNumberGenerator.new()
var base_pos : Vector2
var base_scale : Vector2

func _ready() -> void:
	base_pos = position
	base_scale = scale
	loop()
	loop2()

func loop() -> void:
	var new_pos = base_pos + Vector2(rng.randf_range(-10, 10), rng.randf_range(-10, 10))
	var tween = create_tween()
	tween.tween_property(self, "position", new_pos, rng.randf_range(2, 5)).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await tween.finished
	loop()

func loop2() -> void:
	var new_scale = base_scale + Vector2(rng.randf_range(-0.2, 0.2), rng.randf_range(-0.2, 0.2))
	var tween1 = create_tween()
	tween1.tween_property(self, "scale", new_scale, rng.randf_range(2, 5)).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await tween1.finished
	loop2()
