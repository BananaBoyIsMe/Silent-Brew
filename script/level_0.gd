extends Node2D

var player_load = preload("res://scene/player.tscn")

var player_input = true
var player_input_num = 0

var original_pos_before_walk
var item_true = false
var last_health = 40

var done = true

@onready var black_berry_bush = $blackberry1
@onready var berryitself = $deco/bush3/SbPlant7

func _ready() -> void:
	get_parent().position = Vector2(200, 0)
	get_parent().scale = Vector2(1.5, 1.5)
	global.connect("player_cur_health_toggled", health_change)
	global.connect("add_inventory", new_item)
	
	global.player_cur_health = 30
	audio.stop_all()
	audio.play_bird_forest()
	global.turn = 0
	global.in_cutscene = true
	global.bark_emotion.gone_text(1)
	global.other_emotion.gone_text(2)
	global.other_emotion.visible = true
	global.bark_emotion.visible = true
	global.other_emotion.position.y = 1280
	global.bark_emotion.position.y = 1280
	
	global.player_des_pos = Vector2(5, 3)
	original_pos_before_walk = Vector2(5, 3)
	global.player_des_real_pos = global.find_real_pos(5, 3)
	global.player_last_pos = global.find_real_pos(5, 3)
	var player = player_load.instantiate()
	player.position = $tiles/tile_5_3.position + Vector2(0, -40)
	player.scale = Vector2(0.25, 0.25)
	global.player = player
	add_child(player)
	
	global.bark_emotion.change_character_png("bark13", false)
	await get_tree().create_timer(2).timeout
	var tween_bark_emo = create_tween()
	tween_bark_emo.tween_property(global.bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(1.5).timeout
	global.bark_emotion.change_character_png("bark12", true)
	global.bark_emotion.new_text("\n Welcome to\n the tutorial!", 1)
	await get_tree().create_timer(0.5).timeout
	player_input = false
	#global.bark_emotion.change_character_png("bark1")

func health_change(new_health) -> void:
	if new_health > last_health and player_input_num == 7:
		player_input = true
		player_input_num += 1
		on_user_input_received()
	last_health = new_health
	global.book_on = true
	global.book_on = false

func new_item(item: String):
	#print(item)
	match item:
		"black_berry":
			item_true = true
			black_berry_bush.name = "biashdij"
			berryitself.queue_free()
			#player_input = true
			#player_input_num += 1
			#on_user_input_received()

func on_user_input_received():
	match(player_input_num):
		1:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nTry clicking and holding\nto move to another tile!", 1)
			global.bark_emotion.change_character_png("bark5", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		2:
			global.bark_emotion.gone_text(1)
			global.bark_emotion.change_character_png("bark1", true)
			await get_tree().create_timer(0.3).timeout
			global.in_cutscene = false
		3:
			global.in_cutscene = true
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("Nice! \nBeware you lose 1 hp per\n1 tile moved!", 1)
			global.bark_emotion.change_character_png("bark12", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		4: 
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nWalking is very tiring\nI'll have you know!", 1)
			global.bark_emotion.change_character_png("bark2", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		5: 
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nNow, you can eat berries\nto restore hp!", 1)
			global.bark_emotion.change_character_png("bark13", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		6: 
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("Walk to the berry bush\nto grab the berry\nthen you can click\n it to eat!", 1)
			global.bark_emotion.change_character_png("bark7", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		7:
			global.bark_emotion.gone_text(1)
			global.bark_emotion.change_character_png("bark1", true)
			await get_tree().create_timer(0.3).timeout
			global.in_cutscene = false
		8:
			global.in_cutscene = true
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("Awesome!\nNow I won't die from\nwalking too much!", 1)
			global.bark_emotion.change_character_png("bark12", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		9:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("In the future you'll\nface many scary monster!\n try not to get hit!", 1)
			global.bark_emotion.change_character_png("bark1", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		10:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("You can also click on\n the to do list on the right\n to see what to do!", 1)
			global.bark_emotion.change_character_png("bark2", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		11:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("Most levels want\nyou to get to\n the rainbow fog!", 1)
			global.bark_emotion.change_character_png("bark13", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		12:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("The rainbow fog is\n how you get to\nanother level.", 1)
			global.bark_emotion.change_character_png("bark2", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		13:
			global.bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			global.bark_emotion.new_text("\nSo, let's go into it!", 1)
			global.bark_emotion.change_character_png("bark13", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		14:
			global.bark_emotion.gone_text(1)
			global.bark_emotion.change_character_png("bark1", true)
			await get_tree().create_timer(0.3).timeout
			global.in_cutscene = false

func _input(event):
	if !player_input and (event is InputEventKey or event is InputEventMouseButton):
		#print("User pressed something!")
		player_input = true
		player_input_num += 1
		on_user_input_received()
	elif player_input_num == 2 and global.player_des_pos != original_pos_before_walk and (event is InputEventKey or event is InputEventMouseButton):
		player_input = true
		player_input_num += 1
		on_user_input_received()
	elif player_input_num == 7 and done and (event is InputEventKey or event is InputEventMouseButton):
		var portal = load("res://scene/tiles/portal_fog.tscn").instantiate()
		portal.position = global.find_real_pos(7, 2)
		add_child(portal)
		
		var portal1 = load("res://scene/tiles/portal_fog.tscn").instantiate()
		portal1.position = global.find_real_pos(7, 3)
		add_child(portal1)
		
		var portal2 = load("res://scene/tiles/portal_fog.tscn").instantiate()
		portal2.position = global.find_real_pos(7, 4)
		add_child(portal2)
		done = false
		#if item_true:
		#player_input = true
		#player_input_num += 1
		#on_user_input_received()
