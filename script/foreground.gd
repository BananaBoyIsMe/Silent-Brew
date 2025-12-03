extends CanvasLayer

@onready var foreground_black = $foreground_black
@onready var game_over_item = $SbGameOver
@onready var restart_bt = $SbGameOver/restart_bt

func _ready() -> void:
	global.connect("player_lost_toggled", game_over)
	restart_bt.disabled = true

func game_over(state:bool) -> void:
	restart_bt.disabled = false
	if state:
		var tween = create_tween()
		tween.tween_property(foreground_black, "modulate:a", 0.5, 1)
		var tween2 = create_tween()
		tween2.tween_property(game_over_item, "position:y", 570, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	else:
		var tween = create_tween()
		tween.tween_property(foreground_black, "modulate:a", 0, 1)
		var tween2 = create_tween()
		tween2.tween_property(game_over_item, "position:y", -960, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		restart()

func restart() -> void:
	global.current_level.queue_free()
	global.in_cutscene = false
	global.player_lost = false
	global.player_cur_health = 31
	
	audio.stop_all()
	#audio.play_menu()
	global.inv_on = false
	global.book_on = false
	global.encyclopedia_on = false
	global.map_on = false
	
	audio.play_button()
	get_parent().get_node("paused").deactivate_menu()
	restart_bt.disabled = true

func _on_restart_bt_button_down() -> void:
	global.player_lost = false
