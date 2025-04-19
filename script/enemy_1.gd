extends Node2D

var rng = RandomNumberGenerator.new()

var tile_co = Vector2(0, 0)

var enemy_turn = 0

@onready var sprite = $Sprite2D

func flying() -> void:
	var time = rng.randf_range(0.5, 1.5)
	
	var tween1 = create_tween()
	tween1.tween_property(sprite, "position:y", rng.randf_range(5, 20), time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	var degree_fly = rng.randf_range(75, 85)
	var tween2 = create_tween()
	tween2.tween_property(sprite, "rotation_degrees", degree_fly, time/2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await get_tree().create_timer(time/2).timeout
	var tween3 = create_tween()
	tween3.tween_property(sprite, "rotation_degrees", 90, time/2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(time/2).timeout
	
	
	
	time = rng.randf_range(0.5, 1.5)
	
	var tween4 = create_tween()
	tween4.tween_property(sprite, "position:y", rng.randf_range(-5, -20), time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	degree_fly = rng.randf_range(95, 105)
	var tween5 = create_tween()
	tween5.tween_property(sprite, "rotation_degrees", degree_fly, time/2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await get_tree().create_timer(time/2).timeout
	var tween6 = create_tween()
	tween6.tween_property(sprite, "rotation_degrees", 90, time/2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(time/2).timeout
	
	flying()

func turn_act() -> void:
	#var direction = global.get_neighbors_even_q(tile_co, global.all_room_dict[global.current_room])
	#var line = global.find_straight_path_even_q(tile_co, direction[rng.randi_range(0, direction.size()) - 1] - tile_co, global.all_room_dict[global.current_room])
	#var target_vec = line[line.size()-1]
	#print(line)
	#print(target_vec)
	#var target_pos = Vector2((target_vec.x * 100) + 256 - 960, (target_vec.y * 74) + (256 - (int(target_vec.x) % 2) * 37) - 16 - 540)
	#var tween1 = create_tween()
	#tween1.tween_property(self, "position", target_pos, 0.8).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	#tile_co = target_vec
	
	var direction = global.get_neighbors_even_q(tile_co, global.all_room_dict[global.current_room])
	direction = direction[rng.randi_range(0, direction.size()) - 1]
	var target_pos = Vector2((direction.x * 100) + 256 - 960, (direction.y * 74) + (256 - (int(direction.x) % 2) * 37) - 16 - 540)
	var tween1 = create_tween()
	tween1.tween_property(self, "position", target_pos, 0.8).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tile_co = direction

func _ready() -> void:
	flying()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if enemy_turn < global.turn:
		enemy_turn += 1
		turn_act()
		await get_tree().create_timer(1).timeout
	#print(position)
	pass
