extends Sprite2D

var rng = RandomNumberGenerator.new()
var bat_img1 = preload("res://sprite/enemy/sb_enemy2.png")
var bat_img2 = preload("res://sprite/enemy/sb_enemy3.png")

func updown() -> void:
	var wait = rng.randf_range(0.7, 1.4)
	var half_wait = wait / 2
	var tween1 = create_tween()
	tween1.tween_property(self, "position", Vector2(rng.randf_range(-7, 7), rng.randf_range(-14, 0)), wait).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	var tween2 = create_tween()
	tween2.tween_property(self, "rotation_degrees", rng.randf_range(-7, 7), wait).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await get_tree().create_timer(half_wait).timeout
	#position.y += -25
	self.texture = bat_img1
	await get_tree().create_timer(half_wait).timeout
	
	wait = rng.randf_range(0.7, 1.4)
	half_wait = wait / 2
	tween1 = create_tween()
	tween1.tween_property(self, "position", Vector2(rng.randf_range(-7, 7), rng.randf_range(0, 14)), wait).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween2 = create_tween()
	tween2.tween_property(self, "rotation_degrees", rng.randf_range(-7, 7), wait).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await get_tree().create_timer(half_wait).timeout
	#position.y += 25
	self.texture = bat_img2
	await get_tree().create_timer(half_wait).timeout
	
	updown()

func _ready() -> void:
	updown()
