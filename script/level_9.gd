extends Node2D

var player_load = preload("res://scene/player.tscn")

var player_input = true
var player_input_num = 0

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	global.time.time_change(1)
	get_parent().position = Vector2(60, -20)
	get_parent().scale = Vector2(1.2, 1.2)
	global.connect("turn_changed", next_turn)
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
	global.player_des_pos = Vector2(6, 0)
	global.player_des_real_pos = global.find_real_pos(6, 0)
	global.player_last_pos = global.find_real_pos(6, 0)
	var player = player_load.instantiate()
	player.position = $tiles/tile_6_0.position + Vector2(0, -40)
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
	global.bark_emotion.change_character_png("bark13", true)
	global.bark_emotion.new_text("\nWow... I haven't\n been here in so long.", 1)
	await get_tree().create_timer(1).timeout
	player_input = false
	#global.bark_emotion.change_character_png("bark1")

func on_user_input_received():
	match(player_input_num):
		1:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nI love to walk\non the heally pad!", 1)
			global.bark_emotion.change_character_png("bark12", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		2:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\n... Mom likes to\n fish here a lot...", 1)
			global.bark_emotion.change_character_png("bark3", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		3:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nI should keep going.", 1)
			global.bark_emotion.change_character_png("bark1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		4: 
			global.bark_emotion.gone_text(1)
			global.in_cutscene = false
		5:
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nWhoa...\nIt's the lake monster!", 1)
			global.bark_emotion.change_character_png("bark11", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		6:
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nIt'll rush me down\nIf I move into those lines.", 1)
			global.bark_emotion.change_character_png("bark6", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		7:
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nI need to get out!", 1)
			global.bark_emotion.change_character_png("bark1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		8: 
			global.bark_emotion.gone_text(1)
			global.in_cutscene = false

func _input(event):
	#if event.is_action_pressed("ui_cancel"):
		#return
	if !player_input and (event is InputEventKey or event is InputEventMouseButton):
		#print("User pressed something!")
		player_input = true
		player_input_num += 1
		on_user_input_received()

func next_turn(new_turn) -> void:
	if new_turn == 3:
		var enemy4 = load("res://scene/enemy/enemy_4.tscn").instantiate()
		enemy4.position = Vector2(1198, 735)
		enemy4.scale = Vector2(0.15, 0.15)
		enemy4.z_index = 10
		enemy4.cur_tile = Vector2(9, 6)
		enemy4.next_tile = Vector2(8, 6)
		enemy4.modulate.a = 0
		add_child(enemy4)
		
		var tween = create_tween()
		tween.tween_property(enemy4, "modulate:a", 1, 1.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
		
		global.in_cutscene = true
		player_input = false
		
