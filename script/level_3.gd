extends Node2D

@onready var bark_emotion = $"../../../character_emotion"
@onready var other_emotion = $"../../../character_emotion2"

var player_load = preload("res://scene/player.tscn")

var player_input = true
var player_input_num = 0

func _ready() -> void:
	audio.stop_all()
	audio.play_cave()
	global.turn = 0
	global.in_cutscene = true
	bark_emotion.gone_text(1)
	other_emotion.gone_text(2)
	other_emotion.visible = true
	bark_emotion.visible = true
	other_emotion.position.y = 1280
	bark_emotion.position.y = 1280
	
	global.player_des_pos = Vector2(11, 5)
	global.player_des_real_pos = Vector2(1400, 691)
	global.player_last_pos = Vector2(1400, 691)
	var player = player_load.instantiate()
	player.position = $tiles/tile_11_5.position + Vector2(0, -40)
	player.scale = Vector2(0.25, 0.25)
	global.player = player
	add_child(player)
	
	bark_emotion.change_character_png("bark8", false)
	await get_tree().create_timer(2).timeout
	var tween_bark_emo = create_tween()
	tween_bark_emo.tween_property(bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(1.5).timeout
	bark_emotion.shake_head(0.5, 2)
	await get_tree().create_timer(3.5).timeout
	bark_emotion.change_character_png("bark10", true)
	bark_emotion.new_text("\nUmmm... Where am I?", 1)
	await get_tree().create_timer(1).timeout
	player_input = false
	#bark_emotion.change_character_png("bark1")

func on_user_input_received():
	match(player_input_num):
		1:
			bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			bark_emotion.new_text("\nOh! It's the icy cave!", 1)
			bark_emotion.change_character_png("bark12", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		2:
			bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			bark_emotion.new_text("\nNord told me about how\nSLIPPERY the floor is!", 1)
			bark_emotion.change_character_png("bark8", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		3:
			bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			bark_emotion.new_text("\nHe said the dark tiles\nare super dangerous...", 1)
			bark_emotion.change_character_png("bark11", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		4: 
			bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			bark_emotion.new_text("\nI should get to the fog\nand get out of here.", 1)
			bark_emotion.change_character_png("bark1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		5: 
			bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			bark_emotion.change_character_png("bark1", true)
			global.in_cutscene = false

func _input(event):
	#if event.is_action_pressed("ui_cancel"):
		#return
	if !player_input and (event is InputEventKey or event is InputEventMouseButton):
		#print("User pressed something!")
		player_input = true
		player_input_num += 1
		on_user_input_received()
