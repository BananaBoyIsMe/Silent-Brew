extends Node2D

var stop = false
var paused = false
var rng = RandomNumberGenerator.new()

var pos1 = Vector2(260, 440)
var pos2 = Vector2(1700, 140)
var pos3 = Vector2(1400, 900)

var stpos1 = Vector2(-370, -100)
var stpos2 = Vector2(2600, -200)
var stpos3 = Vector2(1700, 1800)

var stro1 = 50
var stro2 = -60
var stro3 = -75

var ro1 = 5
var ro2 = 0
var ro3 = -25

var pause_stuff = [[], [], [], [], [], [], [], [], [], [], []]

var select_scene = preload("res://scene/select_level.tscn")
var options_scene = preload("res://scene/options.tscn")
var select_scene_real
var options_scene_real

var screen_size = Vector2(1920, 1080)

@onready var screen_dark = $screen_dark
@onready var resume = $resume_bt
@onready var select_level = $select_bt
@onready var options = $options_bt
@onready var credits = $credits_bt
@onready var save_and_exit = $save_and_exit_bt
#@onready var bark_emotion = $"../bark_emotion"
@onready var silent_title = $SilentBrewTitle
@onready var brew_title = $SilentBrewTitle2

@onready var map_icon = $"../map_icon/map_icon"
@onready var map_glow = $"../map_icon/map_icon/map_glow"
@onready var map_image = $"../map_image"

@onready var book_icon = $"../book_icon/book_icon"
@onready var book_glow = $"../book_icon/book_icon/book_glow"
@onready var book_image = $"../encyclopedia"

func get_random_outside_position() -> Vector2:
	var margin = 500

	var edge = rng.randi_range(0, 3)
	var positionn = Vector2()
	match edge:
		0:  # Top
			positionn.x = rng.randf_range(-margin, screen_size.x + margin)
			positionn.y = -margin
		1:  # Bottom
			positionn.x = rng.randf_range(-margin, screen_size.x + margin)
			positionn.y = screen_size.y + margin
		2:  # Left
			positionn.x = -margin
			positionn.y = rng.randf_range(-margin, screen_size.y + margin)
		3:  # Right
			positionn.x = screen_size.x + margin
			positionn.y = rng.randf_range(-margin, screen_size.y + margin)
	return positionn

func activate_menu():
	resume.position = Vector2(827, 393)
	select_level.position = Vector2(827, 515)
	options.position = Vector2(826, 640)
	credits.position = Vector2(823, 770)
	save_and_exit.position = Vector2(819, 899)
	silent_title.position = Vector2(267, 152 - 400)
	brew_title.position = Vector2(1380, 296 - 400)
	
	screen_dark.visible = true
	#var tween = create_tween()
	#tween.tween_property(bark_emotion, "position:y", 1280, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween2 = create_tween()
	tween2.tween_property(screen_dark, "modulate:a", 0.5, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween3 = create_tween()
	tween3.tween_property(silent_title, "position:y", 152, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween4 = create_tween()
	tween4.tween_property(brew_title, "position:y", 296, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween5 = create_tween()
	tween5.tween_property(map_icon, "position:y", -120, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween6 = create_tween()
	tween6.tween_property(book_icon, "position:y", -120, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	
	paused = true
	pause_stuff = []
	for i in range(10):
		#print()
		match rng.randi_range(1, 3):
			1:
				pause_stuff.append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_1.png")
			2:
				pause_stuff.append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_2.png")
			3:
				pause_stuff.append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_3.png")
		var size = rng.randf_range(0.1, 0.35)
		pause_stuff[i].get_child(0).get_child(0).scale = Vector2(size, size)
		pause_stuff[i].get_child(0).get_child(1).scale = Vector2(size, size)
		var item_position = get_random_outside_position()
		pause_stuff[i].get_child(0).position = item_position
		var dir = (screen_size/2 - item_position).normalized()
		#print(dir)
		pause_stuff[i].get_child(0).linear_velocity = dir * rng.randf_range(900, 1700)
		#pause_stuff1[i].get_child(0).apply_impulse(dir * randf_range(1000, 2000))
		pause_stuff[i].get_child(0).angular_velocity = rng.randf_range(-10, 10)
		
		pause_stuff[i].get_child(0).set_collision_mask_value(1, false)
		pause_stuff[i].get_child(0).set_collision_mask_value(rng.randi_range(1, 4), true)
		
		add_child(pause_stuff[i])
	
	#get_tree().paused = true
	for node in get_tree().get_nodes_in_group("Pauseable"):
		node.set_process(false)
	
	if global.current_level != null:
		var tween_level = create_tween()
		tween_level.tween_property(global.current_level, "position:y", -3000, 2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
	var tween1 = create_tween()
	tween1.tween_property(map_image, "position:y", 2040, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	
	global.in_game = false
	resume.visible = true
	select_level.visible = true
	options.visible = true
	credits.visible = true
	save_and_exit.visible = true
	
	stop = true
	await get_tree().create_timer(2).timeout
	stop = false
	
	resume.disabled = false
	select_level.disabled = false
	options.disabled = false
	credits.disabled = false
	save_and_exit.disabled = false
	if global.current_level != null:
		global.current_level.queue_free()
		global.current_level = null

func deactivate_menu():
	#var tween = create_tween()
	#tween.tween_property(bark_emotion, "position:y", 916, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween2 = create_tween()
	tween2.tween_property(screen_dark, "modulate:a", 0, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween3 = create_tween()
	tween3.tween_property(silent_title, "position:y", -400, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween4 = create_tween()
	tween4.tween_property(brew_title, "position:y", -400, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween5 = create_tween()
	tween5.tween_property(map_icon, "position:y", 90, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween6 = create_tween()
	tween6.tween_property(book_icon, "position:y", 90, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	for i in pause_stuff:
		var dir = (i.get_child(0).position - screen_size/2).normalized()
		i.get_child(0).linear_velocity = dir * randf_range(1500, 2500)
		i.get_child(0).angular_velocity = randf_range(-10, 10)
	
	var level = load("res://scene/levels/level_0.tscn").instantiate()
	match global.current_room:
		1:
			level = load("res://scene/levels/level_0.tscn").instantiate()
			get_node("../spawn_zoom/map").scale = Vector2(1.25, 1.25)
		2:
			level = load("res://scene/levels/level_1.tscn").instantiate()
	level.position = Vector2(-1920, -3000)/2
	get_node("../spawn_zoom/map").add_child(level)
	global.current_level = level
	
	var tween_level = create_tween()
	tween_level.tween_property(level, "position", Vector2(-1920, -1080)/2, 2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	global.in_game = true
	resume.disabled = true
	select_level.disabled = true
	options.disabled = true
	credits.disabled = true
	save_and_exit.disabled = true
	resume.visible = false
	select_level.visible = false
	options.visible = false
	credits.visible = false
	save_and_exit.visible = false
	
	stop = true
	await get_tree().create_timer(2).timeout
	stop = false
	for i in pause_stuff:
		i.queue_free()
	pause_stuff = []
	
	#get_tree().paused = true
	paused = false
	for node in get_tree().get_nodes_in_group("Pauseable"):
		node.set_process(true)
	
	screen_dark.visible = false

func _ready() -> void:
	activate_menu()

func _input(event: InputEvent) -> void:
	#pause menu code
	if event is InputEventKey and event.keycode == 4194305 and !paused and event.pressed and !stop:
		activate_menu()

	#elif event is InputEventKey and event.keycode == 4194305 and paused and event.pressed and !stop:
		#deactivate_pause(1)
		#get_parent().start_room()

func _on_resume_bt_button_up() -> void:
	deactivate_menu()

func _on_select_bt_button_up() -> void:
	select_scene_real = select_scene.instantiate()
	select_scene_real.position.x += 2000
	get_parent().add_child(select_scene_real)
	for j in range(10):
		for i in pause_stuff:
			var dir = Vector2(-1, rng.randf_range(-0.5, 0.5))
			i.get_child(0).linear_velocity = dir * 10000
			i.get_child(0).angular_velocity = rng.randf_range(-10, 10)
	
	resume.disabled = true
	select_level.disabled = true
	options.disabled = true
	credits.disabled = true
	save_and_exit.disabled = true
	
	var tween1 = create_tween()
	tween1.tween_property(resume, "position:x", -5000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween2 = create_tween()
	tween2.tween_property(select_level, "position:x", -5000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween3 = create_tween()
	tween3.tween_property(options, "position:x", -5000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween4 = create_tween()
	tween4.tween_property(credits, "position:x", -5000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween5 = create_tween()
	tween5.tween_property(save_and_exit, "position:x", -5000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween6 = create_tween()
	tween6.tween_property(silent_title, "position:x", -5000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween7 = create_tween()
	tween7.tween_property(select_scene_real, "position:x", 0, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween8 = create_tween()
	tween8.tween_property(brew_title, "position:x", -4000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	
	await get_tree().create_timer(0.8).timeout
	
	for i in pause_stuff:
		i.queue_free()
	pause_stuff = []
	
	for i in range(10):
		#print()
		match rng.randi_range(1, 3):
			1:
				pause_stuff.append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_1.png")
			2:
				pause_stuff.append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_2.png")
			3:
				pause_stuff.append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_3.png")
		var size = rng.randf_range(0.1, 0.35)
		pause_stuff[i].get_child(0).get_child(0).scale = Vector2(size, size)
		pause_stuff[i].get_child(0).get_child(1).scale = Vector2(size, size)
		var item_position = Vector2(2800, rng.randf_range(0, 1080))
		pause_stuff[i].get_child(0).position = item_position
		#print(dir)
		pause_stuff[i].get_child(0).linear_velocity = Vector2(-1, 0) * rng.randf_range(1500, 4000)
		#pause_stuff1[i].get_child(0).apply_impulse(dir * randf_range(1000, 2000))
		pause_stuff[i].get_child(0).angular_velocity = rng.randf_range(-50, 50)
		
		pause_stuff[i].get_child(0).set_collision_mask_value(1, false)
		pause_stuff[i].get_child(0).set_collision_mask_value(rng.randi_range(1, 4), true)
		
		add_child(pause_stuff[i])
	
	await get_tree().create_timer(0.2).timeout

func back_to_menu_select() -> void:
	for j in range(10):
		for i in pause_stuff[j]:
			var dir = Vector2(1, rng.randf_range(-0.5, 0.5))
			i.get_child(0).linear_velocity = dir * 10000
			i.get_child(0).angular_velocity = rng.randf_range(-10, 10)
	
	var tween1 = create_tween()
	tween1.tween_property(resume, "position:x", 827, 0.98).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween2 = create_tween()
	tween2.tween_property(select_level, "position:x", 827, 0.98).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween3 = create_tween()
	tween3.tween_property(options, "position:x", 827, 0.98).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween4 = create_tween()
	tween4.tween_property(credits, "position:x", 827, 0.98).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween5 = create_tween()
	tween5.tween_property(save_and_exit, "position:x", 827, 0.98).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween6 = create_tween()
	tween6.tween_property(silent_title, "position:x", 267, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween7 = create_tween()
	tween7.tween_property(select_scene_real, "position:x", 4000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween8 = create_tween()
	tween8.tween_property(brew_title, "position:x", 1380, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	
	await get_tree().create_timer(0.8).timeout
	
	for i in pause_stuff[1]:
		i.queue_free()
	pause_stuff[1] = []
	
	for i in range(10):
		#print()
		match rng.randi_range(1, 3):
			1:
				pause_stuff[1].append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[1][i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_1.png")
			2:
				pause_stuff[1].append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[1][i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_2.png")
			3:
				pause_stuff[1].append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[1][i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_3.png")
		var size = rng.randf_range(0.1, 0.35)
		pause_stuff[1][i].get_child(0).get_child(0).scale = Vector2(size, size)
		pause_stuff[1][i].get_child(0).get_child(1).scale = Vector2(size, size)
		var item_position = Vector2(-1000, rng.randf_range(0, 1080))
		pause_stuff[1][i].get_child(0).position = item_position
		#print(dir)
		pause_stuff[1][i].get_child(0).linear_velocity = Vector2(1, 0) * rng.randf_range(1500, 4000)
		#pause_stuff1[i].get_child(0).apply_impulse(dir * randf_range(1000, 2000))
		pause_stuff[1][i].get_child(0).angular_velocity = rng.randf_range(-50, 50)
		
		pause_stuff[1][i].get_child(0).set_collision_mask_value(1, false)
		pause_stuff[1][i].get_child(0).set_collision_mask_value(rng.randi_range(1, 4), true)
		
		add_child(pause_stuff[1][i])
	
	await get_tree().create_timer(0.2).timeout
	
	resume.disabled = false
	select_level.disabled = false
	options.disabled = false
	credits.disabled = false
	save_and_exit.disabled = false

func _on_options_bt_button_up() -> void:
	options_scene_real = options_scene.instantiate()
	options_scene_real.position.x -= 2000
	get_parent().add_child(options_scene_real)
	for j in range(10):
		for i in pause_stuff[j]:
			var dir = Vector2(1, rng.randf_range(-0.5, 0.5))
			i.get_child(0).linear_velocity = dir * 10000
			i.get_child(0).angular_velocity = rng.randf_range(-10, 10)
	
	resume.disabled = true
	select_level.disabled = true
	options.disabled = true
	credits.disabled = true
	save_and_exit.disabled = true
	
	var tween1 = create_tween()
	tween1.tween_property(resume, "position:x", 6000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween2 = create_tween()
	tween2.tween_property(select_level, "position:x", 6000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween3 = create_tween()
	tween3.tween_property(options, "position:x", 6000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween4 = create_tween()
	tween4.tween_property(credits, "position:x", 6000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween5 = create_tween()
	tween5.tween_property(save_and_exit, "position:x", 6000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween6 = create_tween()
	tween6.tween_property(silent_title, "position:x", 6000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween7 = create_tween()
	tween7.tween_property(options_scene_real, "position:x", 0, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween8 = create_tween()
	tween8.tween_property(brew_title, "position:x", 6000, 0.92).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	
	await get_tree().create_timer(0.8).timeout
	
	for i in pause_stuff[1]:
		i.queue_free()
	pause_stuff[1] = []
	
	for i in range(10):
		#print()
		match rng.randi_range(1, 3):
			1:
				pause_stuff[1].append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[1][i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_1.png")
			2:
				pause_stuff[1].append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[1][i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_2.png")
			3:
				pause_stuff[1].append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[1][i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_3.png")
		var size = rng.randf_range(0.1, 0.35)
		pause_stuff[1][i].get_child(0).get_child(0).scale = Vector2(size, size)
		pause_stuff[1][i].get_child(0).get_child(1).scale = Vector2(size, size)
		var item_position = Vector2(-1200, rng.randf_range(0, 1080))
		pause_stuff[1][i].get_child(0).position = item_position
		#print(dir)
		pause_stuff[1][i].get_child(0).linear_velocity = Vector2(1, 0) * rng.randf_range(1500, 4000)
		#pause_stuff1[i].get_child(0).apply_impulse(dir * randf_range(1000, 2000))
		pause_stuff[1][i].get_child(0).angular_velocity = rng.randf_range(-50, 50)
		
		pause_stuff[1][i].get_child(0).set_collision_mask_value(1, false)
		pause_stuff[1][i].get_child(0).set_collision_mask_value(rng.randi_range(1, 4), true)
		
		add_child(pause_stuff[1][i])
	
	await get_tree().create_timer(0.2).timeout

func back_to_menu_options() -> void:
	for j in range(10):
		for i in pause_stuff[j]:
			var dir = Vector2(-1, rng.randf_range(-0.5, 0.5))
			i.get_child(0).linear_velocity = dir * 10000
			i.get_child(0).angular_velocity = rng.randf_range(-10, 10)
	
	var tween1 = create_tween()
	tween1.tween_property(resume, "position:x", 827, 0.98).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween2 = create_tween()
	tween2.tween_property(select_level, "position:x", 827, 0.98).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween3 = create_tween()
	tween3.tween_property(options, "position:x", 827, 0.98).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween4 = create_tween()
	tween4.tween_property(credits, "position:x", 827, 0.98).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween5 = create_tween()
	tween5.tween_property(save_and_exit, "position:x", 827, 0.98).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween6 = create_tween()
	tween6.tween_property(silent_title, "position:x", 267, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var tween7 = create_tween()
	tween7.tween_property(options_scene_real, "position:x", -4000, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	var tween8 = create_tween()
	tween8.tween_property(brew_title, "position:x", 1380, 1.02).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	
	await get_tree().create_timer(0.8).timeout
	
	for i in pause_stuff[1]:
		i.queue_free()
	pause_stuff[1] = []
	
	for i in range(10):
		#print()
		match rng.randi_range(1, 3):
			1:
				pause_stuff[1].append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[1][i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_1.png")
			2:
				pause_stuff[1].append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[1][i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_2.png")
			3:
				pause_stuff[1].append(load("res://scene/menu/menu_pic_2.tscn").instantiate())
				pause_stuff[1][i].get_child(0).get_child(0).texture = load("res://sprite/menu/sb_menu_3.png")
		var size = rng.randf_range(0.1, 0.35)
		pause_stuff[1][i].get_child(0).get_child(0).scale = Vector2(size, size)
		pause_stuff[1][i].get_child(0).get_child(1).scale = Vector2(size, size)
		var item_position = Vector2(2500, rng.randf_range(0, 1080))
		pause_stuff[1][i].get_child(0).position = item_position
		#print(dir)
		pause_stuff[1][i].get_child(0).linear_velocity = Vector2(-1, 0) * rng.randf_range(1000, 3000)
		#pause_stuff1[i].get_child(0).apply_impulse(dir * randf_range(1000, 2000))
		pause_stuff[1][i].get_child(0).angular_velocity = rng.randf_range(-50, 50)
		
		pause_stuff[1][i].get_child(0).set_collision_mask_value(1, false)
		pause_stuff[1][i].get_child(0).set_collision_mask_value(rng.randi_range(1, 4), true)
		
		add_child(pause_stuff[1][i])
	
	await get_tree().create_timer(0.2).timeout
	
	resume.disabled = false
	select_level.disabled = false
	options.disabled = false
	credits.disabled = false
	save_and_exit.disabled = false

func _on_save_and_exit_bt_button_up() -> void:
	get_tree().quit()
