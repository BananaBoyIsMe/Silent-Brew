extends Node2D

@onready var mini_bark = $character/MiniBarkSleep
@onready var mini_hannah = $character/MiniHannah2
@onready var bark_emotion = $"../../../character_emotion"
@onready var other_emotion = $"../../../character_emotion2"

func _ready() -> void:
	other_emotion.change_character_png("hannah1")
	bark_emotion.change_character_png("bark2")
	await get_tree().create_timer(2).timeout
	#print("Hi")
	var tween_hannah = create_tween()
	tween_hannah.tween_property(mini_hannah, "position", Vector2(800, 330), 4)
	var tween_hannah2 = create_tween()
	tween_hannah2.tween_property(mini_hannah, "modulate:a", 1, 2)
	for i in range(5):
		var tween_hannah3 = create_tween()
		tween_hannah3.tween_property(mini_hannah, "rotation_degrees", 3.5, 0.3)
		await get_tree().create_timer(0.4).timeout
		tween_hannah3 = create_tween()
		tween_hannah3.tween_property(mini_hannah, "rotation_degrees", -3.5, 0.3)
		await get_tree().create_timer(0.4).timeout
	#print("HiHi")
	var tween_hannah4 = create_tween()
	tween_hannah4.tween_property(mini_hannah, "rotation_degrees", 0, 0.3)
	tween_hannah = create_tween()
	tween_hannah.tween_property(mini_hannah, "position", Vector2(800, 490), 3.2)
	var tween_other_emo = create_tween()
	tween_other_emo.tween_property(other_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	var tween_bark_emo = create_tween()
	tween_bark_emo.tween_property(bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	for i in range(4):
		var tween_hannah3 = create_tween()
		tween_hannah3.tween_property(mini_hannah, "rotation_degrees", 3.5, 0.3)
		await get_tree().create_timer(0.4).timeout
		tween_hannah3 = create_tween()
		tween_hannah3.tween_property(mini_hannah, "rotation_degrees", -3.5, 0.3)
		await get_tree().create_timer(0.4).timeout
	tween_hannah4 = create_tween()
	tween_hannah4.tween_property(mini_hannah, "rotation_degrees", 0, 0.3)
	
	await get_tree().create_timer(2).timeout
	
