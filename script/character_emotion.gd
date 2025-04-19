extends Node2D

@onready var character_png = $character_png

@onready var textbox1 = $SbTextBox1
@onready var textbox2 = $SbTextBox2

func change_character_png(change:String) -> void:
	var original_pos = self.position
	var changed = false
	match change:
		"bark1":
			character_png.texture = load("res://sprite/bark/bark_emotion1.png")
			changed = true
		"bark2":
			character_png.texture = load("res://sprite/bark/bark_emotion2.png")
			changed = true
		"hannah1":
			character_png.texture = load("res://sprite/character/hannah_emotion1.png")
			changed = true
	if changed:
		var tween = create_tween()
		tween.tween_property(self, "position:y", original_pos.y + 10, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		await get_tree().create_timer(0.3).timeout
		tween = create_tween()
		tween.tween_property(self, "position:y", original_pos.y, 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)

func new_text(dialogue:String, char: int) -> void:
	match char:
		1:
			pass
		2:
			pass

func shake_head(time: float) -> void:
	var original_pos = self.position
	print(original_pos)
	character_png.texture = load("res://sprite/bark/bark_emotion6.png")
	#var tween1 = create_tween()
	#tween1.tween_property(character_png, "position", original_pos + Vector2(10, 0), 0.5)
	await get_tree().create_timer(time).timeout
	character_png.texture = load("res://sprite/bark/bark_emotion7.png")
	#var tween2 = create_tween()
	#tween2.tween_property(character_png, "position", original_pos + Vector2(-10, 0), 0.5)
	await get_tree().create_timer(time).timeout
	#var tween3 = create_tween()
	#tween3.tween_property(character_png, "position", original_pos, 0.5)
