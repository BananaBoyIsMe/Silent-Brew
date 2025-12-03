extends Node2D

var rng = RandomNumberGenerator.new()

var target_pos = Vector2(0, 0)
var last_target_pos = Vector2(0, 0)
var move_pos = Vector2(0, 0)
var cur_pos = Vector2(0, 0)
@export var cur_tile = Vector2(0, 0)
#@export var speed = 200
@export var next_tile = Vector2(0, 0)

@onready var sprite = $Sprite2D

var player_detected = false

var rock_move = false

var base_scale := Vector2.ONE
var idle_time := 0.0
var idle_strength := 0.03
var idle_speed := 2.5

var idle_timex := 0.0
var idle_strengthx := 0.03
var idle_speedx := 2.0

#var long_one = false
#var long_one_pos = Vector2(0, 0)

func _ready() -> void:
	idle_time = randf_range(0, 1)
	idle_strength = randf_range(0.02, 0.08)
	idle_speed = randf_range(1, 3)
	
	idle_timex = randf_range(0, 1)
	idle_strengthx = randf_range(0.02, 0.08)
	idle_speedx = randf_range(1, 3)
	
	cur_pos = global.find_real_pos(cur_tile.x, cur_tile.y)
	target_pos = global.find_real_pos(next_tile.x, next_tile.y)
	last_target_pos = cur_pos
	move_pos = cur_pos
	global.connect("turn_changed", _on_turn_changed)
	global.connect("move_on_toggled", _on_move_changed)
	#global.connect("enemy_move", _on_enemy_move)
	global.connect("kill_enemy", _enemy_kill)

func _enemy_kill():
	self.queue_free()

#func _on_enemy_move():
	#tween1 = create_tween()
	#tween1.tween_property(self, "position", target_pos, 0.8)

func _on_move_changed(state: bool):
	rock_move = state
	var straight_paths = global.get_straight_lines_even_q(cur_tile, global.all_room_dict_rock[global.current_room])
	for i in range(6):
		if global.player_direction[1] in straight_paths[i] and rock_move:
			#move_pos = global.find_real_pos(straight_paths[i][-1].x, straight_paths[i][-1].y)
			#print(straight_paths[i][-1])
			#long_one_pos = straight_paths[i][-1]
			#long_one = true
			#print(global.get_straight_lines_even_q(cur_tile, global.all_room_dict[global.current_room]))
			#print(str(i) + " : i")
			#print(str(global.player_direction[1]) + " : global.player_direction[1]")
			#target_pos
			#print(str(i) + " bruhhh")
			#match i:
				#0: #up-left
					#pass
				#1: #up
					#pass
				#2: #up-right
					#pass
				#3: #down-right
					#pass
				#4: #down
					#pass
				#5: #down-left
					#pass
			
			while(rock_move):
				move_pos = global.find_real_pos(straight_paths[i][-1].x, straight_paths[i][-1].y)
				#tween1 = create_tween()
				#tween1.tween_property(self, "position", global.find_real_pos(straight_paths[i][-1].x, straight_paths[i][-1].y), 0.8)
				await get_tree().create_timer(0.8).timeout
			return
	
	if rock_move:
		#move_pos = target_pos
		#long_one = false
		#print(global.get_straight_lines_even_q(cur_tile, global.all_room_dict[global.current_room]))
		#print(str(i) + " : i")
		#print(str(global.player_direction[1]) + " : global.player_direction[1]")
		while(rock_move):
			#tween1 = create_tween()
			#tween1.tween_property(self, "position", target_pos, 0.8)
			move_pos = target_pos
			await get_tree().create_timer(0.98).timeout
	else:
		move_pos = last_target_pos
		#long_one = false
		#pass
		#tween1.stop()
		#tween2 = create_tween()
		#tween2.tween_property(self, "position", cur_pos, 0.8)

func _on_turn_changed(_new_turn: int):
	cur_pos = position
	cur_tile = next_tile
	#if long_one:
		#cur_tile = long_one_pos
		#long_one = false
	#for i in range(6):
		#if global.player_direction[1] in global.get_straight_lines_even_q(cur_tile, global.all_room_dict[global.current_room])[i]:
			#print(global.get_straight_lines_even_q(cur_tile, global.all_room_dict[global.current_room]))
			#print(str(i) + " bruhhh")
			#return
	#print(global.get_straight_lines_even_q(cur_tile, global.all_room_dict[global.current_room]))
	
	#if !player_detected:
	#var new_tile
	#while(true):
		#next_tile = cur_tile + Vector2(rng.randi_range(-1, 1), rng.randi_range(-1, 1))
	var new_tile = global.get_neighbors_even_q(cur_tile, global.all_room_dict_rock[global.current_room])
	if new_tile.size() == 0:
		return
	var random_i = randi() % new_tile.size()
	next_tile = new_tile[random_i]
	print(str(next_tile) + ": next tile")
		
	var target_tile = get_parent().get_node("tiles/" + "tile_" + str(int(next_tile.x)) + "_" + str(int(next_tile.y)))
	#if target_tile.input_tile:
		#continue
	last_target_pos = target_pos
	target_pos = target_tile.position
	
			
			#if next_tile in global.all_room[global.current_room]:
				#cur_tile = next_tile
				#break
			#await get_tree().create_timer(0.2).timeout
		
		
	#else:
		#target_pos = global.player.position

func _on_detect_area_entered(area: Area2D) -> void:
	if area.name == "player":
		player_detected = true

func _physics_process(delta: float) -> void:
	var smooth_speed := 2.5
	var new_pos = position.lerp(move_pos + Vector2(0, -28), 1.0 - exp(-smooth_speed * delta))
	if new_pos.x - position.x > 0 and scale.x > 0:
		scale.x = -scale.x
	elif new_pos.x - position.x < 0 and scale.x < 0:
		scale.x = -scale.x
	position = new_pos
	#print(new_pos)
	
	idle_time += delta * idle_speed
	var anim := sin(idle_time)
	sprite.scale.y = base_scale.y * (1.0 + anim * idle_strength)
	
	idle_timex += delta * idle_speedx
	var animx := sin(idle_timex)
	sprite.scale.x = base_scale.x * (1.0 + animx * idle_strengthx)
