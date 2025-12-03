extends Node2D

var player_load = preload("res://scene/player.tscn")

var player_input = true
var player_input_num = 0

func _ready() -> void:
	get_parent().position = Vector2(-30, -10)
	get_parent().scale = Vector2(1.1, 1.1)
	global.player_cur_health = 31
	audio.stop_all()
	audio.play_cave()
	global.turn = 0
	global.in_cutscene = true
	global.bark_emotion.gone_text(1)
	global.other_emotion.gone_text(2)
	global.other_emotion.visible = true
	global.bark_emotion.visible = true
	global.other_emotion.position.y = 1280
	global.bark_emotion.position.y = 1280
	
	global.player_des_pos = Vector2(11, 5)
	global.player_des_real_pos = Vector2(1400, 691)
	global.player_last_pos = Vector2(1400, 691)
	var player = player_load.instantiate()
	player.position = $tiles/tile_11_5.position + Vector2(0, -40)
	player.scale = Vector2(0.25, 0.25)
	global.player = player
	add_child(player)
	
	global.bark_emotion.change_character_png("bark8", false)
	await get_tree().create_timer(2).timeout
	var tween_bark_emo = create_tween()
	tween_bark_emo.tween_property(global.bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(1.5).timeout
	global.bark_emotion.shake_head(0.5, 2)
	await get_tree().create_timer(3.5).timeout
	global.bark_emotion.change_character_png("bark10", true)
	global.bark_emotion.new_text("\nUmmm... Where am I?", 1)
	await get_tree().create_timer(1).timeout
	player_input = false
	#global.bark_emotion.change_character_png("bark1")

func on_user_input_received():
	match(player_input_num):
		1:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nOh! It's the icy cave!", 1)
			global.bark_emotion.change_character_png("bark12", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		2:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nNord told me about how\nSLIPPERY the floor is!", 1)
			global.bark_emotion.change_character_png("bark8", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		3:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nHe said the dark tiles\nare super dangerous...", 1)
			global.bark_emotion.change_character_png("bark11", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		4: 
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nI should get to the fog\nand get out of here.", 1)
			global.bark_emotion.change_character_png("bark1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		5: 
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.change_character_png("bark1", true)
			global.in_cutscene = false

func _input(event):
	#if event.is_action_pressed("ui_cancel"):
		#return
	if !player_input and (event is InputEventKey or event is InputEventMouseButton):
		#print("User pressed something!")
		player_input = true
		player_input_num += 1
		on_user_input_received()
