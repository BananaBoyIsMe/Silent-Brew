extends Node2D

@onready var pause_icon = $pause_icon
@onready var pause_icon2 = $pause_icon2
@onready var pause_glow = $pause_icon/pause_glow
@onready var pause_glow2 = $pause_icon/pause_glow2

@onready var screen_dark = $screen_dark

#func _physics_process(delta: float) -> void:
	#print(map_image.rotation_degrees)

func _ready() -> void:
	global.connect("pause_toggled", _on_pause_toggled)

func _on_pause_toggled(state: bool):
	#print("pause is now:", "On" if state else "Off")
	if state:
		#screen_dark.visible = true
		$"../paused".activate_menu()
	#else:
		#screen_dark.visible = false

func _input(event: InputEvent) -> void:
	#print(event)
	#if event is InputEventKey:
		#if event.is_action_pressed("ui_cancel") and global.in_game:
			#pause_glow.visible = true
			#pause_glow2.visible = true
		#if event.is_action_released("ui_cancel") and global.in_game:
			#pause_glow.visible = false
			#pause_glow2.visible = false
			#global.pause_on = !global.pause_on
	
	if event is InputEventKey:
		if event.is_action_pressed("ui_cancel") and global.in_game:
			global.inv_on = false
			global.map_on = false
			global.book_on = false


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#print(event)
	if event is InputEventMouseButton:
		if event.button_index == 1 and !event.pressed:
			global.pause_on = !global.pause_on
			
			#print("Hi")

func _on_area_2d_mouse_entered() -> void:
	pause_glow.visible = true
	pause_glow2.visible = true

func _on_area_2d_mouse_exited() -> void:
	pause_glow.visible = false
	pause_glow2.visible = false

func _on_yes_bt_button_down() -> void:
	if global.in_game:
		return
	get_tree().paused = true
	$"../paused".activate_menu()
	screen_dark.visible = false

func _on_no_bt_button_down() -> void:
	if global.in_game:
		return
	await get_tree().create_timer(0.1).timeout
	global.pause_on = false
	screen_dark.visible = false
