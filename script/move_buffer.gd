extends Node2D

var cooldown_timer = 0
var once = false
#var move_timer = 0
@onready var move_buffer = $move_buffer

func _physics_process(delta: float) -> void:
	position = get_global_mouse_position() + Vector2(5, 5)
	move_buffer.value = global.move_timer
	#print(move_timer)
	if global.move_now and once:
		once = false
		global.player_direction_num += 1
		if global.player_direction.size() > 2 and global.player_direction_num < global.player_direction.size():
			global.player_des_real_pos = global.player_direction_real_pos[global.player_direction_num]
			#global.player_last_pos = global.player_direction_real_pos[global.player_direction_num]
		
		var tween_walk1 = create_tween()
		tween_walk1.tween_property(global.player, "position", global.player_des_real_pos + Vector2(0, -40), 0.8)
		
	if global.move_now:
		
		#global.move_now = true
		global.move_timer += delta
	else:
		global.move_timer -= delta
		if global.move_timer < 0:
			global.move_timer = 0
	
	if global.move_timer > 0.8:
		once = true
		#global.move_now = false
		if global.player_direction.size() > 1 and global.player_direction_num < global.player_direction.size():
			global.player_des_pos = global.player_direction[global.player_direction_num]
			global.player_last_pos = global.player_direction_real_pos[global.player_direction_num]
		
		#print("Hi")
		#global.player_direction_num += 1
		global.move_timer = 0
		cooldown_timer = 0.2
	
	cooldown_timer -= delta
	
	if cooldown_timer > 0:
		global.move_timer = 0
	
		#cooldown_timer = 0
	#if cooldown_timer <= 0 and !once:
		#once = true
