extends Node2D

var rng = RandomNumberGenerator.new()

@export var target_pos = Vector2(0, 0)
@export var cur_pos = Vector2(0, 0)
@export var cur_tile = Vector2(0, 0)

var player_detected = false

var tween1
var tween2
var tween3

func _ready() -> void:
	global.connect("turn_changed", _on_turn_changed)
	global.connect("move_on_toggled", _on_move_changed)
	global.connect("enemy_move", _on_enemy_move)
	global.connect("kill_enemy", _enemy_kill)

func _enemy_kill():
	self.queue_free()

func _on_enemy_move():
	tween1 = create_tween()
	tween1.tween_property(self, "position", target_pos, 0.8)
	tween2 = create_tween()
	tween2.kill()
	pass

func _on_move_changed(state: bool):
	if state:
		tween1 = create_tween()
		tween1.tween_property(self, "position", target_pos, 0.8)
		tween2 = create_tween()
		tween2.kill()
	else:
		tween2 = create_tween()
		tween2.tween_property(self, "position", cur_pos, 0.8)
		tween1 = create_tween()
		tween1.kill()

func _on_turn_changed(_new_turn: int):
	cur_pos = position
	if !player_detected:
		var next_tile
		while(true):
			next_tile = cur_tile + Vector2(rng.randi_range(-1, 1), rng.randi_range(-1, 1))
			print(str(next_tile))
			if next_tile in global.all_room[global.current_room]:
				cur_tile = next_tile
				break
			#await get_tree().create_timer(0.2).timeout
		target_pos = get_parent().get_node("tiles/" + "tile_" + str(int(cur_tile.x)) + "_" + str(int(cur_tile.y))).position
	else:
		target_pos = global.player.position

func _on_detect_area_entered(area: Area2D) -> void:
	if area.name == "player":
		player_detected = true

func _on_detect_area_exited(area: Area2D) -> void:
	#if area.name == "player":
		#player_detected = false
	pass
