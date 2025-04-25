extends Node2D

@onready var bark_emotion = $"../../../character_emotion"
@onready var other_emotion = $"../../../character_emotion2"

var player_load = preload("res://scene/player.tscn")

var player_input = true
var player_input_num = 0

func _ready() -> void:
	global.in_cutscene = false
	global.player_des_pos = Vector2(2, 1)
	global.player_des_real_pos = Vector2(500, 358)
	global.player_last_pos = Vector2(500, 358)
	var player = player_load.instantiate()
	player.position = $tiles/tile_2_1.position + Vector2(0, -40)
	player.scale = Vector2(0.25, 0.25)
	global.player = player
	add_child(player)
	
	bark_emotion.change_character_png("bark8", false)
	await get_tree().create_timer(2).timeout
	var tween_bark_emo = create_tween()
	tween_bark_emo.tween_property(bark_emotion, "position:y", 900, 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(1.5).timeout
	bark_emotion.shake_head(0.5, 2)
	await get_tree().create_timer(2.5).timeout
	bark_emotion.change_character_png("bark11", true)
	bark_emotion.new_text("\nOh... oh no", 1)
	await get_tree().create_timer(1).timeout
	player_input = false
	#bark_emotion.change_character_png("bark1")

func on_user_input_received():
	match(player_input_num):
		1:
			bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			bark_emotion.new_text("\nIt's so hot here!", 1)
			bark_emotion.change_character_png("bark9", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		2:
			bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			bark_emotion.new_text("\nand scary...", 1)
			bark_emotion.change_character_png("bark11", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		3:
			bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			bark_emotion.new_text("\nI need to get to\n the rainbow fog", 1)
			bark_emotion.change_character_png("bark3", true)
			await get_tree().create_timer(0.5).timeout
			player_input = false
		4: 
			bark_emotion.gone_text(1)
			await get_tree().create_timer(0.3).timeout
			bark_emotion.change_character_png("bark1", true)

func _input(event):
	if !player_input and (event is InputEventKey or event is InputEventMouseButton):
		#print("User pressed something!")
		player_input = true
		player_input_num += 1
		on_user_input_received()
