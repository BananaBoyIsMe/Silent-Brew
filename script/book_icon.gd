extends Node2D

@onready var book_icon = $book_icon
@onready var book_glow = $book_icon/book_glow
@onready var book_image = $"../encyclopedia"

@onready var screen_dark = $screen_dark

#func _physics_process(delta: float) -> void:
	#print(map_image.rotation_degrees)

func _ready() -> void:
	global.connect("book_toggled", _on_book_toggled)

func _on_book_toggled(state: bool):
	#print("Book is now:", "On" if state else "Off")
	if state:
		global.map_on = false
		var tween1 = create_tween()
		tween1.tween_property(book_image, "position:y", 0, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		var tween2 = create_tween()
		tween2.tween_property(book_image, "rotation_degrees", 0, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		var tween3 = create_tween()
		tween3.tween_property(screen_dark, "modulate:a", 0.5, 1)
	else:
		var tween1 = create_tween()
		tween1.tween_property(book_image, "position:y", 2800, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		var tween2 = create_tween()
		tween2.tween_property(book_image, "rotation_degrees", -90, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		var tween3 = create_tween()
		tween3.tween_property(screen_dark, "modulate:a", 0, 1)
	

func _input(event: InputEvent) -> void:
	#print(event)
	if event is InputEventKey:
		#if event.is_action_pressed("ui_book") and event.pressed and global.in_game:
		if (event.keycode == 66 or event.keycode == 69) and event.pressed and global.in_game:
			book_glow.visible = true
		#if event.is_action_pressed("ui_book") and !event.pressed and global.in_game:
		if (event.keycode == 66 or event.keycode == 69) and !event.pressed and global.in_game:
			book_glow.visible = false
			global.book_on = !global.book_on


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#print(event)
	if event is InputEventMouseButton:
		if event.button_index == 1 and !event.pressed:
			global.book_on = !global.book_on
			#print("Hi")

func _on_area_2d_mouse_entered() -> void:
	book_glow.visible = true

func _on_area_2d_mouse_exited() -> void:
	book_glow.visible = false
