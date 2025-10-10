extends Node2D

var player_load = preload("res://scene/player.tscn")

var player_input = true
var player_input_num = 0

@onready var mini_lori = $MiniLori1
@onready var mini_nori = $MiniNori1
@onready var shader_bg = $overlay

func _ready() -> void:
	audio.stop_all()
	#audio.play_bird_forest()
	global.turn = 0
	global.in_cutscene = true
	global.bark_emotion.gone_text(1)
	global.other_emotion.gone_text(2)
	global.other_emotion.visible = true
	global.bark_emotion.visible = true
	global.other_emotion.position.y = 1280
	global.bark_emotion.position.y = 1280
	global.bark_emotion.change_character_png("bark12", false)
	global.other_emotion.change_character_png("lori1", false)
	global.player_des_pos = Vector2(9, 5)
	global.player_des_real_pos = global.find_real_pos(9, 5)
	global.player_last_pos = global.find_real_pos(9, 5)
	var player = player_load.instantiate()
	player.position = $tiles/tile_9_5.position + Vector2(0, -40)
	player.scale = Vector2(0.25, 0.25)
	global.player = player
	add_child(player)
	
	await get_tree().create_timer(2).timeout
	var tween_bark_emo = create_tween()
	tween_bark_emo.tween_property(global.bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	var tween_other_emo = create_tween()
	tween_other_emo.tween_property(global.other_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	global.bark_emotion.change_character_png("bark12", true)
	global.bark_emotion.new_text("\nGranny!", 1)
	await get_tree().create_timer(1).timeout
	player_input = false
	

func on_user_input_received():
	match(player_input_num):
		1:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nBy the star, Hello Bark!", 2)
			global.other_emotion.change_character_png("lori1", true)
			player_input = false
		2:
			global.other_emotion.gone_text(2)
			var tween = create_tween()
			tween.tween_property(mini_lori, "position", mini_lori.position + Vector2(0, 140), 1.5)
			for i in range(2):
				var tween1 = create_tween()
				tween1.tween_property(mini_lori, "rotation_degrees", -5, 0.3)
				await get_tree().create_timer(0.3).timeout
				var tween2 = create_tween()
				tween2.tween_property(mini_lori, "rotation_degrees", 5, 0.3)
				await get_tree().create_timer(0.3).timeout
			var tween3 = create_tween()
			tween3.tween_property(mini_lori, "rotation_degrees", 0, 0.1)
			await get_tree().create_timer(0.2).timeout
			
			global.other_emotion.new_text("\nIt's so good to see you!", 2)
			global.other_emotion.change_character_png("lori1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		3:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("Hey! Gran- ...\n Right... \n I can't say anything...", 1)
			global.bark_emotion.change_character_png("bark11", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		4:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nOh Poor thing,\n you look rough!", 2)
			global.other_emotion.change_character_png("lori1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		5:
			global.other_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("Nori! Stop lazing\n and go get \n some fruit and food!", 2)
			global.other_emotion.change_character_png("lori1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		6:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\n...\n*enthusiastic thumb up*", 2)
			global.other_emotion.change_character_png("nori1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		7:
			var tween1 = create_tween()
			tween1.tween_property(mini_nori, "position", mini_nori.position + Vector2(-100, -100), 1.5)
			var tween2 = create_tween()
			tween2.tween_property(mini_nori, "rotation_degrees", -5, 0.2)
			await get_tree().create_timer(0.2).timeout
			var tween3 = create_tween()
			tween3.tween_property(mini_nori, "rotation_degrees", 5, 0.2)
			await get_tree().create_timer(0.2).timeout
			var tween5 = create_tween()
			tween5.tween_property(mini_nori, "rotation_degrees", 0, 0.2)
			await get_tree().create_timer(0.2).timeout
			var tween4 = create_tween()
			tween4.tween_property(mini_nori, "modulate:a", 0, 0.7)
			global.other_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("Now now, come sit. \n Try and tell us\n what happen to you.", 2)
			global.other_emotion.change_character_png("lori1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		8:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\n*Jestures agressively* \n*Wild arm swinging*", 1)
			global.bark_emotion.change_character_png("bark12", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		9:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nOh dear, you seem to \nhave gone through\n so much.", 2)
			global.other_emotion.change_character_png("lori1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		10:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\n*Yawn silently*\n... zzzzzzzzz", 1)
			global.bark_emotion.change_character_png("bark3", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		11:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("My, you must be\n very tired!\n we'll talk tomorrow then.", 2)
			global.other_emotion.change_character_png("lori1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		12:
			global.other_emotion.gone_text(2)
			var tween_bark_emo = create_tween()
			tween_bark_emo.tween_property(global.bark_emotion, "position:y", 1280, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
			var tween_other_emo = create_tween()
			tween_other_emo.tween_property(global.other_emotion, "position:y", 1280, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
			var tween_other = create_tween()
			tween_other.tween_property(mini_lori, "modulate:a", 0, 2)
			var tweenb = create_tween()
			tweenb.tween_property(global.foreground.get_child(0), "modulate:a", 1, 1.2)
			await get_tree().create_timer(1.5).timeout
			shader_bg.visible = true
			global.time.time_change(1)
			var tweenc = create_tween()
			tweenc.tween_property(global.foreground.get_child(0), "modulate:a", 0, 1.2)
			await get_tree().create_timer(1).timeout
			
			var tween_bark_emo2 = create_tween()
			tween_bark_emo2.tween_property(global.bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
			await get_tree().create_timer(1.5).timeout
			global.bark_emotion.shake_head(0.5, 2)
			await get_tree().create_timer(3.5).timeout
			global.bark_emotion.change_character_png("bark10", true)
			global.bark_emotion.new_text("\n Did I... fall asleep?", 1)
			await get_tree().create_timer(2).timeout
			player_input = false
		13:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nWait... \nMom's still out there!", 1)
			global.bark_emotion.change_character_png("bark9", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		14:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nWhat if she's in danger...\n I need to find her!", 1)
			global.bark_emotion.change_character_png("bark3", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		15:
			global.bark_emotion.gone_text(1)
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
