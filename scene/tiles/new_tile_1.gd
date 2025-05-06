extends Node2D

var mouse_in = false
var sprite_material
var saturation = 1.0
var rng = RandomNumberGenerator.new()

var tile_text_load = preload("res://scene/tiles/tile_text.tscn")

@export var tile_id = 1
@export var tile_co = Vector2(0, 0)
@export var delay_time:float = 0

@onready var tile_tex = $SbTile
var original_scale
var original_modulate

@export var input_tile = false
@export var input_text_str: String

func _ready() -> void:
	global.connect("inv_toggled", disable_tile)
	match rng.randi_range(1, 2):
		1:
			self.rotation_degrees = 180
	match rng.randi_range(1, 2):
		1:
			self.scale.x *= -1
	match tile_id:
		1:
			tile_tex.texture = load("res://sprite/tiles/sb_tile1.png")
		2:
			tile_tex.texture = load("res://sprite/tiles/sb_tile2.png")
		3:
			tile_tex.texture = load("res://sprite/tiles/sb_tile3.png")
			self.scale.x = abs(scale.x)
			self.scale.y = abs(scale.y)
			self.rotation_degrees = 0
			original_scale = self.scale
			await get_tree().create_timer(delay_time).timeout
			ripple()
		33:
			tile_tex.texture = load("res://sprite/tiles/sb_tile3.png")
		4:
			tile_tex.texture = load("res://sprite/tiles/sb_tile4.png")
		5:
			tile_tex.texture = load("res://sprite/tiles/sb_tile5.png")
		55:
			tile_tex.texture = load("res://sprite/tiles/sb_tile5.png")
			original_modulate = self.modulate
			crystal()
		6:
			tile_tex.texture = load("res://sprite/tiles/sb_tile6.png")
			
	#sprite_material = tile_tex.material
	#if sprite_material:
		#sprite_material.set("shader_parameter/saturation", saturation)
	allow_collision()

func crystal() -> void:
	match rng.randi_range(1, 3):
		1:
			var time_change = rng.randf_range(1.5, 3)
			var tween1 = create_tween()
			tween1.tween_property(self, "modulate", original_modulate + Color(rng.randf_range(0.1, 0.3), rng.randf_range(0.1, 0.3), rng.randf_range(0.1, 0.3)), time_change)
			await get_tree().create_timer(time_change).timeout
			var tween2 = create_tween()
			tween2.tween_property(self, "modulate", original_modulate, time_change)
	await get_tree().create_timer(3).timeout
	crystal()

func ripple() -> void:
	var tween1 = create_tween()
	tween1.tween_property(self, "scale", original_scale * 1.09, 0.6).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	await get_tree().create_timer(0.8).timeout
	var tween2 = create_tween()
	tween2.tween_property(self, "scale", original_scale, 0.6).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	await get_tree().create_timer(2.5).timeout
	ripple()

func _physics_process(delta: float) -> void:
	if mouse_in:
		#get_parent().get_node("Camera2D").scale += Vector2(0.1, 0.1)
		tile_tex.scale.x += (1.10-tile_tex.scale.x) * delta * 6
		tile_tex.scale.y += (1.12-tile_tex.scale.y) * delta * 6
	elif !mouse_in:
		tile_tex.scale.x -= (tile_tex.scale.x-1) * delta * 6
		tile_tex.scale.y -= (tile_tex.scale.y-1) * delta * 6
		#self.modulate -= Color(0.01, 0.01, 0.01)
	
	if mouse_in and tile_tex.modulate.r < 1.1:
		tile_tex.modulate += Color(0.02, 0.02, 0.02)
	elif !mouse_in and tile_tex.modulate.r > 1:
		tile_tex.modulate -= Color(0.02, 0.02, 0.02)
	
	#if global.move_now:
		#saturation += delta * 5
		#saturation = min(saturation, 1)
	#
	#if !global.move_now:
		#saturation -= delta * 2
		#saturation = max(0, saturation)
	#
	#if sprite_material:
		#sprite_material.set("shader_parameter/saturation", saturation)

func _on_area_2d_mouse_entered() -> void:
	mouse_in = true

func _on_area_2d_mouse_exited() -> void:
	mouse_in = false

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if global.in_cutscene or !global.in_game or global.inv_on or global.encyclopedia_on or global.map_on:
		global.move_now = false
		return
	if (event is InputEventMouseButton and event.pressed) or (event is InputEventScreenTouch and event.pressed):
		if input_tile:
			var tile_text = tile_text_load.instantiate()
			tile_text.position = get_parent().get_parent().get_local_mouse_position()
			tile_text.get_child(0).text = input_text_str
			tile_text.scale = Vector2(1.1, 1.1)
			get_parent().get_parent().add_child(tile_text)
			#print("Hi")
			return
		global.tile_co = tile_co
		global.player_direction = global.find_shortest_path_even_q(global.player_des_pos, global.tile_co, global.all_room_dict[global.current_room])
		global.player_direction_num = 1
		#print(global.player_direction)
		#print(global.player_des_pos)
		global.player_direction_real_pos = []

		if global.player_direction.size() > 1:
			#global.player_des_pos = global.player_direction[global.player_direction_num]
			for i in global.player_direction:
				global.player_direction_real_pos.append(get_node("../tile_" + str(int(i.x)) + "_" + str(int(i.y))).position)
			global.player_des_real_pos = global.player_direction_real_pos[global.player_direction_num]
			global.player_last_pos = global.player_direction_real_pos[global.player_direction_num - 1]
			#print("../tile_" + str(int(global.player_des_pos.x)) + "_" + str(int(global.player_des_pos.y)))
			#print(global.player_des_real_pos)
			global.move_now = true
		#print("Bye")
	
	if (event is InputEventMouseButton and !event.pressed) or (event is InputEventScreenTouch and !event.pressed):
		global.move_now = false
		#print("Hi")
		

func disable_tile(state: bool) -> void:
	if state:
		$Area2D/CollisionPolygon2D.disabled = true
	else:
		$Area2D/CollisionPolygon2D.disabled = false

func allow_collision():
	await get_tree().create_timer(2).timeout
	$Area2D/CollisionPolygon2D.disabled = false
