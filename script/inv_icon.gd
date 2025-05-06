extends Node2D

@onready var inv_icon = $inv_icon
@onready var inv_glow = $inv_icon/inv_glow
@onready var inv = $"../inventory"

@onready var screen_dark = $screen_dark

#func _physics_process(delta: float) -> void:
	#print(inv_image.rotation_degrees)

func _ready() -> void:
	global.connect("inv_toggled", _on_inv_toggled)

func _on_inv_toggled(state: bool):
	if state:
		global.book_on = false
		global.map_on = false
		var tween1 = create_tween()
		tween1.tween_property(inv, "position:y", 0, 1.25).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		var tween2 = create_tween()
		tween2.tween_property(inv, "rotation_degrees", 0, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		var tween3 = create_tween()
		tween3.tween_property(screen_dark, "modulate:a", 0.4, 1)
	else:
		var tween1 = create_tween()
		tween1.tween_property(inv, "position:y", 3400, 1)
		var tween2 = create_tween()
		tween2.tween_property(inv, "rotation_degrees", -90, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
		var tween3 = create_tween()
		tween3.tween_property(screen_dark, "modulate:a", 0, 1)

func _input(event: InputEvent) -> void:
	if !global.in_game or global.in_cutscene:
		return
	
	if event is InputEventKey:
		if (event.keycode == 70 or event.keycode == 73) and event.pressed and global.in_game:
			inv_glow.visible = true
		if (event.keycode == 70 or event.keycode == 73) and !event.pressed and global.in_game:
			inv_glow.visible = false
			global.inv_on = !global.inv_on

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#print(event)
	
	if event is InputEventMouseButton:
		if !global.in_game or global.in_cutscene:
			return
		
		if event.button_index == 1 and !event.pressed:
			global.inv_on = !global.inv_on

func _on_area_2d_mouse_entered() -> void:
	inv_glow.visible = true

func _on_area_2d_mouse_exited() -> void:
	inv_glow.visible = false
