extends Node2D

var player_load = preload("res://scene/player.tscn")

var player_input = true
var player_input_num = 0

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	get_parent().position = Vector2(0, 0)
	get_parent().scale = Vector2(1.2, 1.2)
	global.player_cur_health = 31
	audio.stop_all()
	audio.play_lava()
	global.connect("turn_changed", melt_floor)
	
	global.turn = 0
	global.in_cutscene = true
	global.bark_emotion.gone_text(1)
	global.other_emotion.gone_text(2)
	global.other_emotion.visible = true
	global.bark_emotion.visible = true
	global.other_emotion.position.y = 1280
	global.bark_emotion.position.y = 1280
	
	#generate player
	match rng.randi_range(1, 4):
		1:
			global.player_des_pos = Vector2(2, 1)
			global.player_des_real_pos = global.find_real_pos(2, 1)
			global.player_last_pos = global.find_real_pos(2, 1)
			var player = player_load.instantiate()
			player.position = $tiles/tile_2_1.position + Vector2(0, -40)
			player.scale = Vector2(0.25, 0.25)
			global.player = player
			add_child(player)
		2:
			global.player_des_pos = Vector2(5, 0)
			global.player_des_real_pos = global.find_real_pos(5, 0)
			global.player_last_pos = global.find_real_pos(5, 0)
			var player = player_load.instantiate()
			player.position = $tiles/tile_5_0.position + Vector2(0, -40)
			player.scale = Vector2(0.25, 0.25)
			global.player = player
			add_child(player)
		3:
			global.player_des_pos = Vector2(1, 2)
			global.player_des_real_pos = global.find_real_pos(1, 2)
			global.player_last_pos = global.find_real_pos(1, 2)
			var player = player_load.instantiate()
			player.position = $tiles/tile_1_2.position + Vector2(0, -40)
			player.scale = Vector2(0.25, 0.25)
			global.player = player
			add_child(player)
		4:
			global.player_des_pos = Vector2(5, 2)
			global.player_des_real_pos = global.find_real_pos(5, 2)
			global.player_last_pos = global.find_real_pos(5, 2)
			var player = player_load.instantiate()
			player.position = $tiles/tile_5_2.position + Vector2(0, -40)
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
	global.bark_emotion.change_character_png("bark11", true)
	global.bark_emotion.new_text("\nOh... oh no", 1)
	await get_tree().create_timer(1).timeout
	player_input = false
	#global.bark_emotion.change_character_png("bark1")

func melt_floor(_turn: int):
	print(global.player_des_pos)
	var tile = get_node("tiles/tile_" + str(int(global.player_des_pos.x)) + "_" + str(int(global.player_des_pos.y)))
	var tween = create_tween()
	tween.tween_property(tile, "scale", Vector2(0, 0), 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func on_user_input_received():
	match(player_input_num):
		1:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nIt's so hot here!", 1)
			global.bark_emotion.change_character_png("bark9", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		2:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nand scary...", 1)
			global.bark_emotion.change_character_png("bark11", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		3:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nI need to get to\n the rainbow fog", 1)
			global.bark_emotion.change_character_png("bark3", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		4: 
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
