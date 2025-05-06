extends Button

@export var id = 0
var dir

func _ready() -> void:
	if global.current_room == 4:
		pass
		#visible = true
	
	match id:
		1:
			dir = Vector2(-1, -0.8).normalized()
		2:
			dir = Vector2(0, -1).normalized()
		3:
			dir = Vector2(1, -0.8).normalized()
		4:
			dir = Vector2(1, 0.8).normalized()
		5:
			dir = Vector2(0, 1).normalized()
		6:
			dir = Vector2(-1, 0.8).normalized()
