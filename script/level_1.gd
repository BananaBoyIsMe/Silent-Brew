extends Node2D

@onready var mini_bark = $character/MiniBarkSleep
@onready var mini_hannah = $character/MiniHannah2

var player_load = preload("res://scene/player.tscn")

var player_input = true
var player_input_num = 0

func _ready() -> void:
	global.connect("remove_item", bush_gone)
	get_parent().position = Vector2(0, 0)
	get_parent().scale = Vector2(1.2, 1.2)
	global.player_cur_health = 31
	global.turn = 0
	global.other_emotion.visible = true
	global.bark_emotion.visible = true
	global.bark_emotion.gone_text(1)
	global.other_emotion.gone_text(2)
	global.in_cutscene = true
	global.other_emotion.position.y = 1280
	global.bark_emotion.position.y = 1280
	global.other_emotion.change_character_png("hannah1", false)
	global.bark_emotion.change_character_png("bark2", false)
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
	tween_other_emo.tween_property(global.other_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	var tween_bark_emo = create_tween()
	tween_bark_emo.tween_property(global.bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
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
	
	global.other_emotion.change_character_png("hannah1", true)
	global.other_emotion.new_text("\nHello my little star~", 2)
	player_input = false
	

func on_user_input_received():
	match(player_input_num):
		1:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nZZZ", 1)
			await get_tree().create_timer(1).timeout
			player_input = false
		2:
			global.bark_emotion.gone_text(1)
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nMust be a nice dream!", 2)
			global.other_emotion.change_character_png("hannah6", true)
			await get_tree().create_timer(1).timeout
			player_input = false
		3:
			global.bark_emotion.gone_text(1)
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\n...", 2)
			global.other_emotion.change_character_png("hannah3", true)
			await get_tree().create_timer(1).timeout
			player_input = false
		4:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nI... \nI swear I'll find a cure.", 2)
			global.other_emotion.change_character_png("hannah5", true)
			await get_tree().create_timer(1).timeout
			player_input = false
		5:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("then...\nI'll finally hear your \nlovely voice again.", 2)
			global.other_emotion.change_character_png("hannah4", true)
			await get_tree().create_timer(1).timeout
			player_input = false
		6:
			global.other_emotion.gone_text(2)
			await get_tree().create_timer(0.3).timeout
			global.other_emotion.new_text("\nGood dreams, my star.", 2)
			global.other_emotion.change_character_png("hannah1", true)
			await get_tree().create_timer(1).timeout
			player_input = false
		7:
			global.other_emotion.gone_text(2)
			var foreground = get_node("../../../foreground/foreground_black")
			var tween = create_tween()
			tween.tween_property(foreground, "modulate:a", 1, 1)
			await get_tree().create_timer(1.2).timeout
			mini_bark.queue_free()
			mini_hannah.queue_free()
			global.bark_emotion.position.y = 1280
			global.other_emotion.position.y = 1280
			await get_tree().create_timer(0.2).timeout
			tween = create_tween()
			tween.tween_property(foreground, "modulate:a", 0, 1)
			
			global.player_des_pos = Vector2(6, 4)
			global.player_des_real_pos = Vector2(900, 580)
			global.player_last_pos = Vector2(900, 580)
			var player = player_load.instantiate()
			player.position = $tiles/tile_6_4.position + Vector2(0, -40)
			player.scale = Vector2(0.25, 0.25)
			global.player = player
			add_child(player)
			
			global.bark_emotion.change_character_png("bark8", false)
			await get_tree().create_timer(1).timeout
			var tween_bark_emo = create_tween()
			tween_bark_emo.tween_property(global.bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
			await get_tree().create_timer(1.5).timeout
			global.bark_emotion.shake_head(0.5, 2)
			await get_tree().create_timer(2.5).timeout
			
			global.bark_emotion.new_text("\nMom is gone again...", 1)
			global.bark_emotion.change_character_png("bark3", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
			
		8:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nSo hungry...", 1)
			global.bark_emotion.change_character_png("bark1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		9:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nLet's get some berries!", 1)
			global.bark_emotion.change_character_png("bark12", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		10:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.change_character_png("bark1", true)
			global.in_cutscene = false
		11:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nShe's gone for\n so long now...", 1)
			global.bark_emotion.change_character_png("bark11", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		12:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nI'm scared...", 1)
			global.bark_emotion.change_character_png("bark9", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		13:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nOh! What is that \nrainbow fog thing...", 1)
			global.bark_emotion.change_character_png("bark10", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		14:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nLet's check it out!", 1)
			global.bark_emotion.change_character_png("bark12", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		15:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.change_character_png("bark1", true)
			global.in_cutscene = false

func next_scene() -> void:
	global.in_cutscene = true
	global.bark_emotion.gone_text(1)
	global.bark_emotion.change_character_png("bark8", false)
	global.bark_emotion.new_text("\nWanna sleep...", 1)
	#global.bark_emotion.new_text("\nIt's been a day now...\nwhere is mom?", 1)
	
	await get_tree().create_timer(2.4).timeout
	global.bark_emotion.gone_text(1)
	global.other_emotion.gone_text(2)
	var foreground = get_node("../../../foreground/foreground_black")
	var tween = create_tween()
	tween.tween_property(foreground, "modulate:a", 1, 1)
	await get_tree().create_timer(1.2).timeout
	global.bark_emotion.position.y = 1280
	global.other_emotion.position.y = 1280
	
	
	var portal = load("res://scene/tiles/portal_fog.tscn").instantiate()
	portal.position = Vector2(1500, 802)
	add_child(portal)
	
	var portal2 = load("res://scene/tiles/portal_fog.tscn").instantiate()
	portal2.position = Vector2(1000, 395)
	add_child(portal2)
	
	var portal3 = load("res://scene/tiles/portal_fog.tscn").instantiate()
	portal3.position = Vector2(500, 654)
	add_child(portal3)
	
	await get_tree().create_timer(0.2).timeout
	tween = create_tween()
	tween.tween_property(foreground, "modulate:a", 0, 1)
	
	await get_tree().create_timer(1.5).timeout
	
	global.bark_emotion.change_character_png("bark8", false)
	await get_tree().create_timer(0.5).timeout
	var tween_bark_emo = create_tween()
	tween_bark_emo.tween_property(global.bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(1.5).timeout
	global.bark_emotion.shake_head(0.5, 2)
	await get_tree().create_timer(3.5).timeout
	
	global.bark_emotion.gone_text(1)
	global.bark_emotion.new_text("\nWhere is mom?", 1)
	global.bark_emotion.change_character_png("bark10", true)
	await get_tree().create_timer(0.5).timeout
	player_input = false
	pass

func _input(event):
	#if event.is_action_pressed("ui_cancel"):
		#return
	if !player_input and (event is InputEventKey or event is InputEventMouseButton):
		#print("User pressed something!")
		player_input = true
		player_input_num += 1
		on_user_input_received()

func bush_gone(item) -> void:
	match item:
		"blackberry1":
			$bush/bush5/SbPlant7.queue_free()
			$blackberry1.queue_free()
		"blackberry2":
			$bush/bush3/SbPlant7.queue_free()
			$blackberry2.queue_free()
		"snow1":
			$bush/bush2/SbPlant2.queue_free()
			$snow1.queue_free()
		"snow2":
			$bush/bush4/SbPlant4.queue_free()
			$snow2.queue_free()
