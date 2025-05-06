extends Node2D

var rng = RandomNumberGenerator.new()

@export var cur_tile = Vector2(0, 0)
@export var direction = 1
@export var cur_tile_pos = Vector2(0, 0)
@export var next_tile = Vector2(0, 0)
@export var next_tile_pos = Vector2(0, 0)
@export var cur_rotation = 0

var tween1
var tween2
var tween3
#vector2(0, -17)

@onready var sprite = $Sprite2D

func _ready() -> void:
	audio.play_bird_forest()
	#tween1 = create_tween()
	#tween2 = create_tween()
	#tween3 = create_tween()
	#cur_tile_pos = self.position
	self.rotation_degrees = cur_rotation
	global.connect("turn_changed", _on_turn_changed)
	global.connect("move_on_toggled", _on_move_changed)
	global.connect("enemy_move", _on_enemy_move)
	global.connect("kill_enemy", _enemy_kill)

func _enemy_kill():
	self.queue_free()

func _on_enemy_move():
	tween1 = create_tween()
	tween1.tween_property(self, "position", next_tile_pos, 0.8)
	tween2 = create_tween()
	tween2.kill()

func _on_move_changed(state: bool):
	if state:
		tween1 = create_tween()
		tween1.tween_property(self, "position", next_tile_pos, 0.8)
		tween2 = create_tween()
		tween2.kill()
	else:
		tween2 = create_tween()
		tween2.tween_property(self, "position", cur_tile_pos, 0.8)
		tween1 = create_tween()
		tween1.kill()

func _on_turn_changed(_new_turn: int):
	match direction:
		1:
			#left_up
			if int(cur_tile.x) % 2 == 0:
				cur_tile += Vector2(-1, -1)
			else:
				cur_tile += Vector2(-1, 0)
		2:
			#up
			cur_tile += Vector2(0, 1)
		3:
			#right_up
			if int(cur_tile.x) % 2 == 0:
				cur_tile += Vector2(1, -1)
			else:
				cur_tile += Vector2(1, 0)
		4:
			#right_down
			if int(cur_tile.x) % 2 == 0:
				cur_tile += Vector2(1, 0)
			else:
				cur_tile += Vector2(1, 1)
		5:
			#down
			cur_tile += Vector2(0, 1)
		6:
			#left_down
			if int(cur_tile.x) % 2 == 0:
				cur_tile += Vector2(-1, 0)
			else:
				cur_tile += Vector2(-1, 1)
	
	while(true):
		direction = rng.randi_range(1, 6)
		var new_next_tile = next_tile
		match direction:
			1:
				#left_up
				if int(new_next_tile.x) % 2 == 0:
					new_next_tile += Vector2(-1, -1)
				else:
					new_next_tile += Vector2(-1, 0)
				cur_rotation = 30
			2:
				#up
				new_next_tile += Vector2(0, 1)
				cur_rotation = 90
			3:
				#right_up
				if int(new_next_tile.x) % 2 == 0:
					new_next_tile += Vector2(1, -1)
				else:
					new_next_tile += Vector2(1, 0)
				cur_rotation = -30
			4:
				#right_down
				if int(new_next_tile.x) % 2 == 0:
					new_next_tile += Vector2(1, 0)
				else:
					new_next_tile += Vector2(1, 1)
				cur_rotation = 30
			5:
				#down
				new_next_tile += Vector2(0, 1)
				cur_rotation = -90
			6:
				#left_down
				if int(new_next_tile.x) % 2 == 0:
					new_next_tile += Vector2(-1, 0)
				else:
					new_next_tile += Vector2(-1, 1)
				cur_rotation = -30
		
		if new_next_tile in global.all_room[global.current_room]:
			cur_tile = next_tile
			next_tile = new_next_tile
			break
	
	cur_tile_pos = get_parent().get_node("tiles/" + "tile_" + str(int(cur_tile.x)) + "_" + str(int(cur_tile.y))).position
	next_tile_pos = get_parent().get_node("tiles/" + "tile_" + str(int(next_tile.x)) + "_" + str(int(next_tile.y))).position
	
	var tween_rot = create_tween()
	tween_rot.tween_property(self, "rotation_degrees", cur_rotation, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	#print("Hi")
	pass
