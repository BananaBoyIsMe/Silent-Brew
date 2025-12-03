extends Node2D

@onready var collision = $player/CollisionShape2D
#@onready var sprite_material = $Player_sprite.material
var sprite_material
var saturation = 1.0
var tween_walk1
var sliding

var once = true
var once2 = true

var undo

func _ready() -> void:
	#print(get_parent().get_parent().get_parent().get_parent().get_node("paused"))
	collision.position = Vector2(1, 155)
	#print("Hi")
	global.player = self
	sprite_material = get_parent().material
	#print(sprite_material)
	global.connect("move_on_toggled", _on_move_toggled)
	global.connect("player_lost_toggled", player_lost_now)

func slide() -> void:
	#print(global.player_direction)
	global.in_cutscene = true
	#var dir = global.player_direction[1] - global.player_direction[0]
	var real_dir = ((global.player_direction_real_pos[1] + Vector2(0, -40)) - (global.player_direction_real_pos[0] + Vector2(0, -40))).normalized()
	#print(real_dir)
	sliding = create_tween()
	sliding.tween_property(global.player, "position", global.player.position + real_dir * 700, 3)
	#if dir.x % 2 == 1:
		#pass
	#else:
		#pass

func player_lost_now(_state: bool)-> void:
	
	pass

func _on_move_toggled(state: bool):
	if global.current_room == 4:
		
		#if state:
			##var new_pos = (global.find_real_pos(global.player_direction[1].x, global.player_direction[1].y) - (global.player_last_pos - Vector2(0, -40))).normalized() * 2
			#var new_pos = global.find_real_pos(global.player_direction[1].x, global.player_direction[1].y)
			#audio.play_walking()
			#tween_walk1 = create_tween()
			#tween_walk1.tween_property(self, "position", new_pos + Vector2(0, -40), 0.5)
		#else:
			#var tween_walk2 = create_tween()
			#tween_walk2.tween_property(self, "position", global.player_last_pos + Vector2(0, -40), 0.5)
			#var tween2 = create_tween()
			#tween2.tween_property(self, "rotation_degrees", 0, 0.3)
		return
	if state:
		audio.play_walking()
		tween_walk1 = create_tween()
		tween_walk1.tween_property(self, "position", global.player_des_real_pos + Vector2(0, -40), 0.8)
		#tween_walk1.kill()
		#for i in range(20):
			#if !global.move_now:
				#break
			#var tween = create_tween()
			#tween.tween_property(self, "rotation_degrees", 7, 0.3)
			#await tween.finished
			#if !global.move_now:
				#break
			#var tween1 = create_tween()
			#tween1.tween_property(self, "rotation_degrees", -7, 0.3)
			#await tween1.finished
	if !state:
		#print(global.player_last_pos)
		#tween_walk1.kill()
		#tween_walk1 = create_tween()
		#tween_walk1.tween_property(self, "position", global.player_last_pos + Vector2(0, -40), global.move_timer)
		var tween_walk2 = create_tween()
		tween_walk2.tween_property(self, "position", global.player_last_pos + Vector2(0, -40), 0.8)
		var tween2 = create_tween()
		tween2.tween_property(self, "rotation_degrees", 0, 0.3)

func _physics_process(_delta: float) -> void:
	#if !global.move_now and self.rotation_degrees != 0:
		#self.rotation_degrees = move_toward(self.rotation_degrees, 0, 0.8)
	#if global.move_now:
		#self.position.x = move_toward(position.x, global.player_des_real_pos.x, 0.8 * 2.5)
		#self.position.y = move_toward(position.y, global.player_des_real_pos.y - 40, 0.8 * 2)
	global.player_cur_pos = self.position
	
	#var path_num = global.player_direction.find(global.player_des_pos) + 1
	#if path_num >= global.player_direction.size():
		#path_num = global.player_direction.size() - 1
	#var target_vec = global.player_direction[path_num]
	#var target_pos = Vector2((target_vec.x * 100) + 256 - 960, (target_vec.y * 74) + (256 - (int(target_vec.x) % 2) * 37) - 64 - 540)
	#
	#var past_pos = Vector2((global.player_des_pos.x * 100) + 256 - 960, (global.player_des_pos.y * 74) + (256 - (int(global.player_des_pos.x) % 2) * 37) - 64 - 540)
	#
	#if global.move_now:
		#saturation += delta * 5
		#saturation = min(saturation, 10)
		

func activate_portal() -> void:
	global.completed_level[global.current_room] = -1
	audio.play_portal()
	await get_tree().create_timer(0.1).timeout
	global.in_game = false
	var tween = create_tween()
	tween.tween_property(global.current_level, "position:y", global.current_level.position.y + 1500, 0.7)
	var tween1 = create_tween()
	tween1.tween_property(get_parent().get_parent().get_parent().get_parent().get_node("character_emotion"), "position:y", 1280, 0.6)
	var tween2 = create_tween()
	tween2.tween_property(get_parent().get_parent().get_parent().get_parent().get_node("character_emotion2"), "position:y", 1280, 0.6)
	global.emit_signal("kill_enemy")
	await get_tree().create_timer(0.4).timeout
	var tween3 = create_tween()
	tween3.tween_property(global.current_level, "modulate:a", 0, 0.5)
	await tween3.finished
	global.current_level.queue_free()
	global.current_room += 1
	get_parent().get_parent().get_parent().get_parent().get_node("paused").deactivate_menu()
	
	await get_tree().create_timer(0.1).timeout
	self.queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var regex := RegEx.new()
	regex.compile("\\d")
	var no_numbers = regex.sub(area.name, "", true)
	#print(no_numbers)
	match no_numbers:
		"enemy":
			global.player_cur_health -= 10
			#set_process_input(false)
			global.move_now = false
			global.bark_emotion.cur_player_input_num = -1
			global.bark_emotion.player_input = true
			global.in_cutscene = true
			global.bark_emotion.split_text_clean("@that hurts!", "9") 
			global.bark_emotion.cur_player_input_num = -1
			
			var tween = create_tween()
			tween.tween_property(self,"modulate", Color(0.9, 0.4, 0.4), 0.3)
			await get_tree().create_timer(0.3).timeout
			var tween1 = create_tween()
			tween1.tween_property(self,"modulate", Color(1, 1, 1), 0.5)
			#set_process_input(true)
			
			#audio.play_died()
			#global.in_game = false
			#var tween = create_tween()
			#tween.tween_property(global.current_level, "position:y", global.current_level.position.y + 1500, 0.7)
			#var tween1 = create_tween()
			#tween1.tween_property(get_parent().get_parent().get_parent().get_parent().get_node("character_emotion"), "position:y", 1280, 0.6)
			#var tween2 = create_tween()
			#tween2.tween_property(get_parent().get_parent().get_parent().get_parent().get_node("character_emotion2"), "position:y", 1280, 0.6)
			#
			#await get_tree().create_timer(0.4).timeout
			#var tween3 = create_tween()
			#tween3.tween_property(global.current_level, "modulate:a", 0, 0.5)
			#await tween3.finished
			#global.current_level.queue_free()
			#get_parent().get_parent().get_parent().get_parent().get_node("paused").deactivate_menu()
			#
			#await get_tree().create_timer(0.1).timeout
			#self.queue_free()
			#return
		"portal":
			global.completed_level[global.current_room] = -1
			audio.play_portal()
			await get_tree().create_timer(0.1).timeout
			global.in_game = false
			var tween = create_tween()
			tween.tween_property(global.current_level, "position:y", global.current_level.position.y + 1500, 0.7)
			var tween1 = create_tween()
			tween1.tween_property(get_parent().get_parent().get_parent().get_parent().get_node("character_emotion"), "position:y", 1280, 0.6)
			var tween2 = create_tween()
			tween2.tween_property(get_parent().get_parent().get_parent().get_parent().get_node("character_emotion2"), "position:y", 1280, 0.6)
			global.emit_signal("kill_enemy")
			await get_tree().create_timer(0.4).timeout
			var tween3 = create_tween()
			tween3.tween_property(global.current_level, "modulate:a", 0, 0.5)
			await tween3.finished
			global.current_level.queue_free()
			global.current_room += 1
			get_parent().get_parent().get_parent().get_parent().get_node("paused").deactivate_menu()
			
			await get_tree().create_timer(0.1).timeout
			self.queue_free()
			return
		"hole":
			audio.play_died()
			global.in_game = false
			var tween = create_tween()
			tween.tween_property(global.current_level, "position:y", global.current_level.position.y + 1500, 0.7)
			var tween1 = create_tween()
			tween1.tween_property(get_parent().get_parent().get_parent().get_parent().get_node("character_emotion"), "position:y", 1280, 0.6)
			var tween2 = create_tween()
			tween2.tween_property(get_parent().get_parent().get_parent().get_parent().get_node("character_emotion2"), "position:y", 1280, 0.6)
			
			await get_tree().create_timer(0.4).timeout
			var tween3 = create_tween()
			tween3.tween_property(global.current_level, "modulate:a", 0, 0.5)
			await tween3.finished
			global.current_level.queue_free()
			get_parent().get_parent().get_parent().get_parent().get_node("paused").deactivate_menu()
			
			await get_tree().create_timer(0.1).timeout
			self.queue_free()
			return
		"coming_soon":
			audio.play_died()
			global.in_game = false
			var tween = create_tween()
			tween.tween_property(global.current_level, "position:y", global.current_level.position.y - 1500, 0.7).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
			var tween1 = create_tween()
			tween1.tween_property(get_parent().get_parent().get_parent().get_parent().get_node("character_emotion"), "position:y", 1280, 0.6)
			var tween2 = create_tween()
			tween2.tween_property(get_parent().get_parent().get_parent().get_parent().get_node("character_emotion2"), "position:y", 1280, 0.6)
			
			await get_tree().create_timer(0.4).timeout
			var tween3 = create_tween()
			tween3.tween_property(global.current_level, "modulate:a", 1, 0.5)
			await tween3.finished
			
			#self.queue_free()
			return
		"blackberry":
			undo = false
			await get_tree().create_timer(0.7).timeout
			
			if !undo:
				global.emit_signal("add_inventory", "black_berry")
				global.emit_signal("remove_item", area.name)
				global.inv_on = false
				global.inv_on = !global.inv_on
				if once2 and global.current_room == 1:
					once2 = false
					var bark_emotion = $"../../../../character_emotion"
					bark_emotion.gone_text(1)
					await get_tree().create_timer(0.3).timeout
					bark_emotion.new_text("Nice! \nBlack Salmon Berry! \nTasty!", 1)
					bark_emotion.change_character_png("bark1", true)
					await get_tree().create_timer(10).timeout
					bark_emotion.gone_text(1)
					global.inv_on = false
					get_parent().next_scene()
		"snow":
			undo = false
			await get_tree().create_timer(0.7).timeout
			
			if !undo:
				global.emit_signal("remove_item", area.name)
				global.emit_signal("add_inventory", "snow")
				global.inv_on = false
				global.inv_on = !global.inv_on
				if once:
					once = false
					var bark_emotion = $"../../../../character_emotion"
					bark_emotion.gone_text(1)
					await get_tree().create_timer(0.3).timeout
					bark_emotion.new_text("That's snow berry!\nMama said ... \nit's poisonous...", 1)
					bark_emotion.change_character_png("bark1", true)
					await get_tree().create_timer(5).timeout
					bark_emotion.gone_text(1)
		"water_cry":
			undo = false
			await get_tree().create_timer(0.7).timeout
			
			if !undo:
				global.emit_signal("add_inventory", "water_cry")
				global.inv_on = false
				global.inv_on = !global.inv_on
	
	if global.current_room == 4 and area.name.contains("blockk"):
		audio.play_walking()
		sliding.kill()
		#sliding.kill(self, "position")
		var parts = area.name.split("_")
		var numbers = []
		for i in range(1, parts.size()):
			numbers.append(int(parts[i]))
		sliding = create_tween()
		sliding.tween_property(global.player, "position", Vector2(numbers[2], numbers[3]) + Vector2(0, -40), 0.6)
		global.in_cutscene = false
		global.player_des_pos = Vector2(numbers[0], numbers[1])
		global.player_last_pos = global.player_direction_real_pos[0]
		global.player_des_real_pos = Vector2(numbers[2], numbers[3]) + Vector2(0, -40)


func _on_player_area_exited(area: Area2D) -> void:
	if area.name == "blackberry":
		undo = true
