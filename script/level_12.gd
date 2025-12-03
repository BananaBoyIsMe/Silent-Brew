extends Node2D

var player_load = preload("res://scene/player.tscn")

var player_input = true
var player_input_num = 0

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var tweenbb = create_tween()
	tweenbb.tween_property(global.foreground.get_child(0), "modulate:a", 0, 1.2)
	get_parent().position = Vector2(0, 0)
	get_parent().scale = Vector2(1.2, 1.2)
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
	#global.other_emotion.change_character_png("nord1", false)
	await get_tree().create_timer(2).timeout
	var tween_bark_emo = create_tween()
	tween_bark_emo.tween_property(global.bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	#var tween_other_emo = create_tween()
	#tween_other_emo.tween_property(global.other_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(1.5).timeout
	global.bark_emotion.shake_head(0.5, 2)
	await get_tree().create_timer(3.5).timeout
	global.bark_emotion.change_character_png("bark10", true)
	global.bark_emotion.new_text("Wait!, how am I\nback here? Did I\n get teleported again?", 1)
	await get_tree().create_timer(1).timeout
	player_input = false
	#global.bark_emotion.change_character_png("bark1")

func on_user_input_received():
	match(player_input_num):
		1:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nWhy is that thing\nhere too!", 1)
			global.bark_emotion.change_character_png("bark9", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		2:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nI have get out.", 1)
			global.bark_emotion.change_character_png("bark1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		3:
			global.bark_emotion.gone_text(1)
			global.in_cutscene = false
			player_input = false

func _input(event):
	if !player_input and (event is InputEventKey or event is InputEventMouseButton):
		#print("User pressed something!")
		player_input = true
		player_input_num += 1
		on_user_input_received()
