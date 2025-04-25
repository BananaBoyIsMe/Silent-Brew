extends Node2D

@onready var collision = $Area2D/CollisionShape2D
#@onready var sprite_material = $Player_sprite.material
var sprite_material
var saturation = 1.0
var tween_walk1

func _ready() -> void:
	#print("Hi")
	global.player = self
	sprite_material = get_parent().material
	#print(sprite_material)
	global.connect("move_on_toggled", _on_move_toggled)

func _on_move_toggled(state: bool):
	if state:
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
		

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "enemy":
		await get_tree().create_timer(0.1).timeout
		get_parent().get_parent().end_room()
		get_parent().get_parent().get_node("paused").activate_pause(1)
		collision.position.x += 1000
	
