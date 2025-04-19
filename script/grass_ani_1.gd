extends Node2D

var rng = RandomNumberGenerator.new()

var state = 0

#@onready var grass_sprite = $grass
var speed = 0.5

@onready var animate_player = $AnimationPlayer

func _ready() -> void:
	dancing()

func dancing() -> void:
	match state:
		0:
			animate_player.play("go_right")
		1:
			animate_player.play_backwards("go_right")
		2:
			animate_player.play("go_left")
		3:
			animate_player.play_backwards("go_left")
	speed = rng.randf_range(0.5, 2)
	state += 1
	if state > 3:
		state = 0
	await get_tree().create_timer(speed).timeout
	dancing()
	pass
