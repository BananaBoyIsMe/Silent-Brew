extends Node2D

@export var cur_tile = Vector2(0, 0)
@export var next_tile = Vector2(0, 0)

var rng = RandomNumberGenerator.new()

var ball_move = false
#var ball_move_again = false
var tween1
var tween2
var player_detected = false

#var directions_even = [
		#Vector2(1, 0),  # Right
		#Vector2(-1, 0),  # Left
		#Vector2(0, 1),  # Down
		#Vector2(0, -1),  # Up
		#Vector2(1, -1),  # Up-right
		#Vector2(-1, -1)  # Up-left
	#]
	#
	#var directions_odd = [
		#Vector2(1, 0),  # Right
		#Vector2(-1, 0),  # Left
		#Vector2(0, 1),  # Down
		#Vector2(0, -1),  # Up
		#Vector2(1, 1),  # Down-right
		#Vector2(-1, 1)  # Down-left
	#]

func _ready() -> void:
	global.connect("turn_changed", new_turn)
	global.connect("move_on_toggled", move_now)

func move_now(state: bool) -> void:
	ball_move = state
	if ball_move:
		while(ball_move):
			tween1 = create_tween()
			tween1.tween_property(self, "position", global.find_real_pos(next_tile.x, next_tile.y), 0.8)
			await get_tree().create_timer(0.98).timeout
	else:
		tween2 = create_tween()
		tween2.tween_property(self, "position", global.find_real_pos(cur_tile.x, cur_tile.y), 0.8)

func new_turn() -> void:
	#ball_move_again = true
	if !player_detected:
		while(true):
			next_tile = cur_tile + Vector2(rng.randi_range(-1, 1), rng.randi_range(-1, 1))
			#print(str(next_tile1))
			if next_tile in global.all_room[global.current_room] and next_tile != Vector2(0, 0):
				cur_tile = next_tile
				break
	else:
		#target_pos = global.player.position
		pass
	pass
