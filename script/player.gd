extends Node2D

@onready var collision = $Area2D/CollisionShape2D
#@onready var sprite_material = $Player_sprite.material
var sprite_material
var saturation = 1.0

func _ready() -> void:
	global.player = self
	sprite_material = get_parent().material
	#print(sprite_material)

func _physics_process(delta: float) -> void:
	var path_num = global.player_direction.find(global.player_des_pos) + 1
	if path_num >= global.player_direction.size():
		path_num = global.player_direction.size() - 1
	var target_vec = global.player_direction[path_num]
	var target_pos = Vector2((target_vec.x * 100) + 256 - 960, (target_vec.y * 74) + (256 - (int(target_vec.x) % 2) * 37) - 64 - 540)
	
	var past_pos = Vector2((global.player_des_pos.x * 100) + 256 - 960, (global.player_des_pos.y * 74) + (256 - (int(global.player_des_pos.x) % 2) * 37) - 64 - 540)
	
	if global.move_now:
		saturation += delta * 5
		saturation = min(saturation, 10)
		
		var speed = log(position.distance_to(target_pos)/ log(2))
		position = position.move_toward(target_pos, speed * 50 * delta)
		if (position).distance_to(target_pos) <= 5:
			if global.player_des_pos != target_vec:
				global.turn += 1
			global.player_des_pos = target_vec
	
	if !global.move_now:
		saturation -= delta * 2
		saturation = max(0, saturation)
	
	if sprite_material:
		sprite_material.set("shader_parameter/saturation", saturation)
	
	if !global.move_now and global.player.position != past_pos:
		global.player.position.x = move_toward(global.player.position.x
		, past_pos.x
		, 0.05 * abs(global.player.position.x - past_pos.x))
		
		global.player.position.y = move_toward(global.player.position.y
		, past_pos.y
		, 0.05 * abs(global.player.position.y - past_pos.y))
		
		#print(global.player.position)
		#print(target_pos)
	
	#if global.move_now:
		#var path_num = global.player_direction.find(global.player_des_pos) + 1
		#if path_num >= global.player_direction.size():
			#path_num = global.player_direction.size() - 1
		#print(path_num)
		#var target_vec = global.player_direction[path_num]
		#var target_pos = Vector2((target_vec.x * 100) + 256 - 960, (target_vec.y * 74) + (256 - (int(target_vec.x) % 2) * 37) - 64 - 540)
		##var past_pos = Vector2((global.player_des_pos.x * 100) + 256 - 960, (global.player_des_pos.y * 74) + (256 - (int(global.player_des_pos.x) % 2) * 37) - 64 - 540)
		##var speed = log(position.distance_to(target_pos)/ log(2))
		#if ((position).distance_to(target_pos) <= 20):
			#global.player_des_pos = target_vec
		##if ((position).distance_to(target_pos) <= 2):
		#if !((position).distance_to(target_pos) <= 2):
			##position = position.move_toward(target_pos, speed * 100 * delta)
			#position = position.move_toward(target_pos, 100 * delta)
		#print(target_pos)
		
		# slope = -0.37
		# y = -0.37x -161.52

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "enemy":
		await get_tree().create_timer(0.1).timeout
		get_parent().get_parent().end_room()
		get_parent().get_parent().get_node("paused").activate_pause(1)
		collision.position.x += 1000
	
