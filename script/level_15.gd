extends Node2D

var player_load = preload("res://scene/player.tscn")

var player_input = true
var player_input_num = 0

var rng = RandomNumberGenerator.new()
@onready var sound_bloom = $SbPlant8

func _ready() -> void:
	global.time.time_change(0)
	get_parent().position = Vector2(0, 0)
	get_parent().scale = Vector2(1.2, 1.2)
	global.player_cur_health = 31
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
	global.other_emotion.change_character_png("hannah1", false)
	await get_tree().create_timer(2).timeout
	var tween_bark_emo = create_tween()
	tween_bark_emo.tween_property(global.bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	var tween_other_emo = create_tween()
	tween_other_emo.tween_property(global.other_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(1.5).timeout
	global.bark_emotion.shake_head(0.5, 2)
	await get_tree().create_timer(3.5).timeout
	global.bark_emotion.change_character_png("bark12", true)
	global.bark_emotion.new_text("\nMom?", 1)
	await get_tree().create_timer(1).timeout
	player_input = false
	#global.bark_emotion.change_character_png("bark1")

func on_user_input_received():
	match(player_input_num):
		1:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nBark! You're back!", 2)
			global.other_emotion.change_character_png("hannah1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		2:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\n*Vigorous nodding*", 1)
			global.bark_emotion.change_character_png("bark13", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		3:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("I was worried when\nyou disappeared suddenly\nin front of me...", 2)
			global.other_emotion.change_character_png("nord1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		4:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nI think you've been\nteleporting too much!", 2)
			global.other_emotion.change_character_png("hannah3", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		5:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("You might suddenly be\nteleported again...so\nI'll hold on to you.", 2)
			global.other_emotion.change_character_png("hannah2", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		6:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("It's ok! your mom\nwill hold on to you so\nshe won't lose you again.", 2)
			global.other_emotion.change_character_png("nord1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		7:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nAlso I...\nI got good news too.", 2)
			global.other_emotion.change_character_png("hannah1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		8:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nWhat is it?", 1)
			global.bark_emotion.change_character_png("bark10", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		9:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nHere!\n*show sound bloom*", 2)
			sound_bloom.visible = true
			var tween2 = create_tween()
			tween2.tween_property(sound_bloom, "modulate:a", 1, 2)
			var tween = create_tween()
			tween.tween_property(sound_bloom, "position:y", sound_bloom.position.y - 20, 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
			global.other_emotion.change_character_png("hannah1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		10:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("It's the plant mom\nhas been searching\nfor forever!", 1)
			global.bark_emotion.change_character_png("bark12", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		11:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nI... \nI can get my voice back!", 1)
			global.bark_emotion.change_character_png("bark13", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		12: 
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nLooks like your wish\ncame true!", 2)
			global.other_emotion.change_character_png("hannah6", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		13: 
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nI'll make you\nthe sound potion now.", 2)
			global.other_emotion.change_character_png("hannah1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		14:
			global.other_emotion.gone_text(2)
			var tween_bark_emo = create_tween()
			tween_bark_emo.tween_property(global.bark_emotion, "position:y", 1280, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
			var tween_other_emo = create_tween()
			tween_other_emo.tween_property(global.other_emotion, "position:y", 1280, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
			var tweenb = create_tween()
			tweenb.tween_property(global.foreground.get_child(0), "modulate:a", 1, 1.2)
			await get_tree().create_timer(1.2).timeout
			var tweenall = create_tween()
			tweenall.tween_property(self, "position:y", -2650, 1.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
			await get_tree().create_timer(0.5).timeout
			var tweenbb = create_tween()
			tweenbb.tween_property(global.foreground.get_child(0), "modulate:a", 0, 2)
	
func _input(event):
	#if event.is_action_pressed("ui_cancel"):
		#return
	if !player_input and (event is InputEventKey or event is InputEventMouseButton):
		#print("User pressed something!")
		player_input = true
		player_input_num += 1
		on_user_input_received()
