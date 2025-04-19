extends Node2D

@onready var map_icon = $map_icon
@onready var map_glow = $map_icon/map_glow
@onready var map_image = $"../map_image"

@onready var screen_dark = $screen_dark

#func _physics_process(delta: float) -> void:
	#print(map_image.rotation_degrees)

func _ready() -> void:
	global.connect("map_toggled", _on_map_toggled)

func _on_map_toggled(state: bool):
	if state:
		global.book_on = false
		var tween1 = create_tween()
		tween1.tween_property(map_image, "position:y", 500, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		var tween2 = create_tween()
		tween2.tween_property(map_image, "rotation_degrees", 0, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		var tween3 = create_tween()
		tween3.tween_property(screen_dark, "modulate:a", 0.5, 1)
	else:
		var tween1 = create_tween()
		tween1.tween_property(map_image, "position:y", 2040, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		var tween2 = create_tween()
		tween2.tween_property(map_image, "rotation_degrees", -90, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		var tween3 = create_tween()
		tween3.tween_property(screen_dark, "modulate:a", 0, 1)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == 77 and event.pressed and global.in_game:
			map_glow.visible = true
		if event.keycode == 77 and !event.pressed and global.in_game:
			map_glow.visible = false
			global.map_on = !global.map_on


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#print(event)
	if event is InputEventMouseButton:
		if event.button_index == 1 and !event.pressed:
			global.map_on = !global.map_on

func _on_area_2d_mouse_entered() -> void:
	map_glow.visible = true

func _on_area_2d_mouse_exited() -> void:
	map_glow.visible = false
