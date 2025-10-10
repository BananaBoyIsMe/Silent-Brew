extends Node2D

var player_load = preload("res://scene/player.tscn")

var player_input = true
var player_input_num = 0

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	audio.stop_all()
	
	global.turn = 0
	global.in_cutscene = true
	global.bark_emotion.gone_text(1)
	global.other_emotion.gone_text(2)
	global.other_emotion.visible = true
	global.bark_emotion.visible = true
	global.other_emotion.position.y = 1280
	global.bark_emotion.position.y = 1280
	
	#generate player
	global.player_des_pos = Vector2(6, 3)
	global.player_des_real_pos = global.find_real_pos(6, 3)
	global.player_last_pos = global.find_real_pos(6, 3)
	var player = player_load.instantiate()
	player.position = $tiles/tile_6_3.position + Vector2(0, -40)
	player.scale = Vector2(0.25, 0.25)
	global.player = player
	add_child(player)
	
	global.bark_emotion.change_character_png("bark8", false)
	global.other_emotion.change_character_png("nord1", false)
	await get_tree().create_timer(2).timeout
	var tween_bark_emo = create_tween()
	tween_bark_emo.tween_property(global.bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	var tween_other_emo = create_tween()
	tween_other_emo.tween_property(global.other_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(1.5).timeout
	global.bark_emotion.shake_head(0.5, 2)
	await get_tree().create_timer(3.5).timeout
	global.bark_emotion.change_character_png("bark12", true)
	global.bark_emotion.new_text("\nUncle Nord!!!", 1)
	await get_tree().create_timer(1).timeout
	player_input = false
	#global.bark_emotion.change_character_png("bark1")

func on_user_input_received():
	match(player_input_num):
		1:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nHey, kiddo!\nYou're ok?", 2)
			global.other_emotion.change_character_png("nord1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		2:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("*Vigorous nodding*", 1)
			global.bark_emotion.change_character_png("bark13", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		3:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("I'm glad you're ok\n but the town is\n dangerous...", 2)
			global.other_emotion.change_character_png("nord1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		4:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nYesterday, there was a\n tentacle monster.", 2)
			global.other_emotion.change_character_png("nord1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		5:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("I think it came from\n the stars and it\n destroyed the town!", 2)
			global.other_emotion.change_character_png("nord1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		6:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("Most people escaped\n somewhere... I'm hiding \n in this mine.", 2)
			global.other_emotion.change_character_png("nord1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		7:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nYour mom was here\n for an hour too.", 2)
			global.other_emotion.change_character_png("nord1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		8:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("Wait what? \nI'm getting closer\n to mom?", 1)
			global.bark_emotion.change_character_png("bark13", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		9:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("Come here and\n let's wait this out...\n it's dangerous outside.", 2)
			global.other_emotion.change_character_png("nord1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		10:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("I'm so close\n to mom! I still\n wanna go out...", 1)
			global.bark_emotion.change_character_png("bark1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		11: 
			global.bark_emotion.gone_text(1)
			var tween = create_tween()
			tween.tween_property(self, "position:y", -2150, 1.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
			var tween_bark_emo1 = create_tween()
			tween_bark_emo1.tween_property(global.bark_emotion, "position:y", 1280, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
			var tween_other_emo2 = create_tween()
			tween_other_emo2.tween_property(global.other_emotion, "position:y", 1280, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
			#global.

func _input(event):
	#if event.is_action_pressed("ui_cancel"):
		#return
	if !player_input and (event is InputEventKey or event is InputEventMouseButton):
		#print("User pressed something!")
		player_input = true
		player_input_num += 1
		on_user_input_received()
