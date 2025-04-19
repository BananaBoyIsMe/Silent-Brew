extends Node2D

var once = false
var once2 = false
var once3 = false
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

var timer = 0

@onready var screen_dark = $screen_dark
@onready var resume = $resume_bt
@onready var save_and_exit = $save_and_exit_bt

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if once3:
		if screen_dark.modulate.a > 0:
			screen_dark.modulate.a -= 1 * delta
		get_node("menu1").position.x = move_toward(get_node("menu1").position.x, stpos1.x, 4 * delta * max(abs(get_node("menu1").position.distance_to(pos1)), 35))			
		get_node("menu1").position.y = move_toward(get_node("menu1").position.y, stpos1.y, 4 * delta * max(abs(get_node("menu1").position.distance_to(pos1)), 35))
		get_node("menu2").position.x = move_toward(get_node("menu2").position.x, stpos2.x, 4 * delta * max(abs(get_node("menu2").position.distance_to(pos2)), 35))
		get_node("menu2").position.y = move_toward(get_node("menu2").position.y, stpos2.y, 4 * delta * max(abs(get_node("menu2").position.distance_to(pos2)), 35))
		get_node("menu3").position.x = move_toward(get_node("menu3").position.x, stpos3.x, 4 * delta * max(abs(get_node("menu3").position.distance_to(pos3)), 35))
		get_node("menu3").position.y = move_toward(get_node("menu3").position.y, stpos3.y, 4 * delta * max(abs(get_node("menu3").position.distance_to(pos3)), 35))
		get_node("menu1").rotation_degrees = move_toward(get_node("menu1").rotation_degrees, stro1, 1 * delta * max(abs(get_node("menu1").rotation_degrees - ro1), 2))
		get_node("menu2").rotation_degrees = move_toward(get_node("menu2").rotation_degrees, stro2, 1 * delta * max(abs(get_node("menu2").rotation_degrees - ro2), 2))
		get_node("menu3").rotation_degrees = move_toward(get_node("menu3").rotation_degrees, stro3, 1 * delta * max(abs(get_node("menu3").rotation_degrees - ro3), 2))
		timer += delta
	if get_tree().paused and once:
		var sprite = Sprite2D.new()
		sprite.texture = load("res://sprite/menu/sb_menu_1.png")
		sprite.name = "menu1"
		sprite.z_index = 1200
		sprite.scale /= 3
		sprite.position = stpos1
		sprite.rotation_degrees = stro1
		add_child(sprite)
		var sprite2 = Sprite2D.new()
		sprite2.texture = load("res://sprite/menu/sb_menu_2.png")
		sprite2.name = "menu2"
		sprite2.z_index = 1200
		sprite2.scale /= 3
		sprite2.position = stpos2
		sprite2.rotation_degrees = stro2
		add_child(sprite2)
		var sprite3 = Sprite2D.new()
		sprite3.texture = load("res://sprite/menu/sb_menu_3.png")
		sprite3.name = "menu3"
		sprite3.z_index = 1200
		sprite3.scale /= 3
		sprite3.position = stpos3
		sprite3.rotation_degrees = stro3
		add_child(sprite3)
		once = false
	elif !get_tree().paused and once2:
		get_node("menu1").queue_free()
		get_node("menu2").queue_free()
		get_node("menu3").queue_free()
		once2 = false
		screen_dark.visible = false
	
	if get_tree().paused and !once3:
		if screen_dark.modulate.a < 0.5:
			screen_dark.modulate.a += 1 * delta
		#print(screen_dark.modulate.a)
		get_node("menu1").position.x = move_toward(get_node("menu1").position.x, pos1.x, 3 * delta * abs(get_node("menu1").position.distance_to(pos1)))			
		get_node("menu1").position.y = move_toward(get_node("menu1").position.y, pos1.y, 3 * delta * abs(get_node("menu1").position.distance_to(pos1)))
		get_node("menu2").position.x = move_toward(get_node("menu2").position.x, pos2.x, 3 * delta * abs(get_node("menu2").position.distance_to(pos2)))
		get_node("menu2").position.y = move_toward(get_node("menu2").position.y, pos2.y, 3 * delta * abs(get_node("menu2").position.distance_to(pos2)))
		get_node("menu3").position.x = move_toward(get_node("menu3").position.x, pos3.x, 3 * delta * abs(get_node("menu3").position.distance_to(pos3)))
		get_node("menu3").position.y = move_toward(get_node("menu3").position.y, pos3.y, 3 * delta * abs(get_node("menu3").position.distance_to(pos3))) 
		get_node("menu1").rotation_degrees = move_toward(get_node("menu1").rotation_degrees, ro1, 1 * delta * abs(get_node("menu1").rotation_degrees - ro1))
		get_node("menu2").rotation_degrees = move_toward(get_node("menu2").rotation_degrees, ro2, 1 * delta * abs(get_node("menu2").rotation_degrees - ro2))
		get_node("menu3").rotation_degrees = move_toward(get_node("menu3").rotation_degrees, ro3, 1 * delta * abs(get_node("menu3").rotation_degrees - ro3))
		#print()
		#get_node("menu1").rotation_degrees += delta * (get_node("menu1").rotation_degrees - ro1)
		#get_node("menu2").rotation_degrees += delta * (get_node("menu2").rotation_degrees - ro2)
		#get_node("menu3").rotation_degrees += delta * (get_node("menu3").rotation_degrees - ro3)
		#print(abs(get_node("menu1").position.distance_to(pos1)))
		#print(get_node("menu1").position)
		#print(abs(get_node("menu2").position.distance_to(pos2)))
		#print(abs(get_node("menu3").position.distance_to(pos3)))
	if !get_tree().paused and timer > 1.5 and once3:
		once2 = true
		once3 = false
		#timer = 0
	pass

func _input(event: InputEvent) -> void:
	#pause menu code
	if event is InputEventKey and event.keycode == 4194305 and !get_tree().paused and event.pressed:
		get_tree().paused = true
		timer = 0
		once2 = false
		once3 = false
		once = true
		resume.disabled = false
		save_and_exit.disabled = false
		resume.visible = true
		save_and_exit.visible = true
		screen_dark.visible = true
		#await get_tree().create_timer(1).timeout
	elif event is InputEventKey and event.keycode == 4194305 and get_tree().paused and event.pressed:
		get_tree().paused = false
		timer = 0
		once = false
		once3 = true
		resume.disabled = true
		save_and_exit.disabled = true
		resume.visible = false
		save_and_exit.visible = false
		#await get_tree().create_timer(1).timeout


func _on_resume_bt_button_up() -> void:
	get_tree().paused = false
	timer = 0
	once = false
	once3 = true
	resume.disabled = true
	save_and_exit.disabled = true
	resume.visible = false
	save_and_exit.visible = false
