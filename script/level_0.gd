extends Node2D

@onready var mini_bark = $character/MiniBarkSleep
@onready var mini_hannah = $character/MiniHannah2
@onready var bark_emotion = $"../../../character_emotion"
@onready var other_emotion = $"../../../character_emotion2"

var player_load = preload("res://scene/player.tscn")

var player_input = true
var player_input_num = 0

func _ready() -> void:
	other_emotion.change_character_png("hannah1", false)
	bark_emotion.change_character_png("bark2", false)
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
	
	
	var tween_hannah5 = create_tween()
	tween_hannah5.tween_property(mini_hannah, "position", mini_hannah.position + Vector2(10, 20), 1)
	await get_tree().create_timer(0.5).timeout
	mini_hannah.texture = load("res://sprite/character/mini_hannah3.png")
	mini_hannah.scale = Vector2(0.08, 0.08)
	await get_tree().create_timer(0.5).timeout
	
	other_emotion.change_character_png("hannah1", true)
	other_emotion.new_text("\nHello my little star~", 2)
	player_input = false
	

func on_user_input_received():
	match(player_input_num):
		1:
			other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			bark_emotion.new_text("\nZZZ", 1)
			await get_tree().create_timer(1).timeout
			player_input = false
		2:
			bark_emotion.gone_text(1)
			other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			other_emotion.new_text("\nMust be a nice dream!", 2)
			other_emotion.change_character_png("hannah6", true)
			await get_tree().create_timer(1).timeout
			player_input = false
		3:
			bark_emotion.gone_text(1)
			other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			other_emotion.new_text("\n...", 2)
			other_emotion.change_character_png("hannah3", true)
			await get_tree().create_timer(1).timeout
			player_input = false
		4:
			other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			other_emotion.new_text("\nI... \nI swear I'll find a cure.", 2)
			other_emotion.change_character_png("hannah5", true)
			await get_tree().create_timer(1).timeout
			player_input = false
		5:
			other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			other_emotion.new_text("then...\nI'll finally hear your \nlovely voice again.", 2)
			other_emotion.change_character_png("hannah4", true)
			await get_tree().create_timer(1).timeout
			player_input = false
		6:
			other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			other_emotion.new_text("\nGood dreams, my star.", 2)
			other_emotion.change_character_png("hannah1", true)
			await get_tree().create_timer(1).timeout
			player_input = false
		7:
			other_emotion.gone_text(2)
			var foreground = get_node("../../../foreground/foreground_black")
			var tween = create_tween()
			tween.tween_property(foreground, "modulate:a", 1, 1)
			await get_tree().create_timer(1.2).timeout
			mini_bark.queue_free()
			mini_hannah.queue_free()
			bark_emotion.position.y = 1280
			other_emotion.position.y = 1280
			await get_tree().create_timer(0.2).timeout
			tween = create_tween()
			tween.tween_property(foreground, "modulate:a", 0, 1)
			global.in_cutscene = false
			
			global.player_des_pos = Vector2(6, 4)
			global.player_des_real_pos = Vector2(900, 580)
			global.player_last_pos = Vector2(900, 580)
			var player = player_load.instantiate()
			player.position = $tiles/tile_6_4.position + Vector2(0, -40)
			player.scale = Vector2(0.25, 0.25)
			global.player = player
			add_child(player)
			
			bark_emotion.change_character_png("bark8", false)
			await get_tree().create_timer(1).timeout
			var tween_bark_emo = create_tween()
			tween_bark_emo.tween_property(bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
			await get_tree().create_timer(1.5).timeout
			bark_emotion.shake_head(0.5, 2)
			await get_tree().create_timer(2.5).timeout
			
			bark_emotion.new_text("\nMom is gone again...", 1)
			bark_emotion.change_character_png("bark2", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
			
		8:
			bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			bark_emotion.new_text("\nSo hungry...", 1)
			bark_emotion.change_character_png("bark1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		9:
			bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			bark_emotion.new_text("\nLet's get some berries!", 1)
			bark_emotion.change_character_png("bark12", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		10:
			bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			bark_emotion.change_character_png("bark1", true)

func _input(event):
	if !player_input and (event is InputEventKey or event is InputEventMouseButton):
		#print("User pressed something!")
		player_input = true
		player_input_num += 1
		on_user_input_received()
