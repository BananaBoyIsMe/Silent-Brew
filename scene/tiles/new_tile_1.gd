extends Node2D

var mouse_in = false
var tile_co = Vector2(0, 0)
var sprite_material
var saturation = 1.0
var rng = RandomNumberGenerator.new()

@export var tile_id = 1
@export var delay_time:float = 0

@onready var tile_tex = $SbTile
var original_scale
var original_modulate

func _ready() -> void:
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
	if (event is InputEventMouseButton and event.pressed) or (event is InputEventScreenTouch and event.pressed):
		#if global.player_des_pos != global.player_direction[-1]:
			#print(global.tween999)
			#global.player.position.x = (global.player_des_pos.x * 100) + 256
			#global.player.position.y = (global.player_des_pos.y * 74) + (256 - (int(global.player_des_pos.x) % 2) * 37) - 64
			#await get_tree().create_timer(0.1).timeout
			#pass
		#var target_pos = Vector2((tile_co.x * 100) + 256 - 960, (tile_co.y * 74) + (256 - (int(tile_co.x) % 2) * 37) - 64 - 540)
		#print(target_pos)
		#if !global.player.position.distance_to(target_pos) <= 5:
		global.player_direction = global.find_shortest_path_even_q(global.player_des_pos, tile_co, global.all_room_dict[global.current_room])
		#print(global.player_direction)
		global.move_now = true
	
	if (event is InputEventMouseButton and !event.pressed) or (event is InputEventScreenTouch and !event.pressed):
		global.move_now = false
		

func allow_collision():
	await get_tree().create_timer(2).timeout
	$Area2D/CollisionPolygon2D.disabled = false
