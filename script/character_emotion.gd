extends Node2D

@onready var character_png = $character_png

@onready var textbox1 = $SbTextBox1
@onready var textbox2 = $SbTextBox2

func change_character_png(change:String, changed:bool) -> void:
	var original_pos = self.position
	if changed:
		var tween = create_tween()
		tween.tween_property(self, "position:y", original_pos.y + 10, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
		await get_tree().create_timer(0.1).timeout
	match change:
		"bark1":
			character_png.texture = load("res://sprite/bark/bark_emotion1.png")
			changed = true
		"bark2":
			character_png.texture = load("res://sprite/bark/bark_emotion2.png")
			changed = true
		"bark3":
			character_png.texture = load("res://sprite/bark/bark_emotion3.png")
			changed = true
		"bark8":
			character_png.texture = load("res://sprite/bark/bark_emotion8.png")
			changed = true
		"bark9":
			character_png.texture = load("res://sprite/bark/bark_emotion9.png")
			changed = true
		"bark10":
			character_png.texture = load("res://sprite/bark/bark_emotion10.png")
			changed = true
		"bark11":
			character_png.texture = load("res://sprite/bark/bark_emotion11.png")
			changed = true
		"bark12":
			character_png.texture = load("res://sprite/bark/bark_emotion12.png")
			changed = true
		"bark13":
			character_png.texture = load("res://sprite/bark/bark_emotion13.png")
			changed = true
		"hannah1":
			character_png.texture = load("res://sprite/character/hannah_emotion1.png")
			changed = true
		"hannah2":
			character_png.texture = load("res://sprite/character/hannah_emotion2.png")
			changed = true
		"hannah3":
			character_png.texture = load("res://sprite/character/hannah_emotion3.png")
			changed = true
		"hannah4":
			character_png.texture = load("res://sprite/character/hannah_emotion4.png")
			changed = true
		"hannah5":
			character_png.texture = load("res://sprite/character/hannah_emotion5.png")
			changed = true
		"hannah6":
			character_png.texture = load("res://sprite/character/hannah_emotion6.png")
			changed = true
	
	if changed:
		var tween = create_tween()
		tween.tween_property(self, "position:y", original_pos.y, 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC)

func new_text(dialogue:String, charr: int) -> void:
	match charr:
		1:
			$SbTextBox1/Label1.text = dialogue
			var tween = create_tween()
			tween.tween_property(textbox1, "scale", Vector2(0.4, 0.4), 0.4).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		2:
			$SbTextBox2/Label2.text = dialogue
			var tween = create_tween()
			tween.tween_property(textbox2, "scale", Vector2(0.4, 0.4), 0.4).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

func gone_text(charr: int) -> void:
	match charr:
		1:
			var tween = create_tween()
			tween.tween_property(textbox1, "scale", Vector2(0, 0), 0.4).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
		2:
			var tween = create_tween()
			tween.tween_property(textbox2, "scale", Vector2(0, 0), 0.4).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)

func shake_head(time: float, amount: int) -> void:
	var original_pos = character_png.position
	#print(original_pos)
	for i in range(amount):
		var tween1 = create_tween()
		tween1.tween_property(character_png, "position", original_pos + Vector2(5, 0), 0.2)
		await tween1.finished
		character_png.texture = load("res://sprite/bark/bark_emotion6.png")
		await get_tree().create_timer(time).timeout
		
		var tween2 = create_tween()
		tween2.tween_property(character_png, "position", original_pos + Vector2(-5, 0), 0.2)
		await tween2.finished
		#await get_tree().create_timer((time/2)).timeout
		character_png.texture = load("res://sprite/bark/bark_emotion7.png")
		await get_tree().create_timer(time).timeout
		
	var tween3 = create_tween()
	tween3.tween_property(character_png, "position", original_pos, 0.5)
	await tween3.finished
	character_png.texture = load("res://sprite/bark/bark_emotion1.png")

func nod_head(time: float, amount: int) -> void:
	var original_pos = character_png.position
	#print(original_pos)
	for i in range(amount):
		var tween1 = create_tween()
		tween1.tween_property(character_png, "position", original_pos + Vector2(5, 0), 0.2)
		await tween1.finished
		character_png.texture = load("res://sprite/bark/bark_emotion4.png")
		await get_tree().create_timer(time).timeout
		
		var tween2 = create_tween()
		tween2.tween_property(character_png, "position", original_pos + Vector2(-5, 0), 0.2)
		await tween2.finished
		#await get_tree().create_timer((time/2)).timeout
		character_png.texture = load("res://sprite/bark/bark_emotion5.png")
		await get_tree().create_timer(time).timeout
		
	var tween3 = create_tween()
	tween3.tween_property(character_png, "position", original_pos, 0.5)
	await tween3.finished
	character_png.texture = load("res://sprite/bark/bark_emotion1.png")
