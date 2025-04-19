extends Node2D

var rng = RandomNumberGenerator.new()

var state = 0

#@onready var grass_sprite = $grass
var speed = 0.5
@export var delay_speed = 0.5

@onready var animate_player = $AnimationPlayer

func _ready() -> void:
	delay_speed = self.position.x / 1920 * 4
	await get_tree().create_timer(delay_speed).timeout
	dancing()

func dancing() -> void:
	match state:
		0:
			animate_player.play("grass_right")
		1:
			animate_player.play_backwards("grass_right")
	#speed = rng.randf_range(0.2, 1)
	speed = 0.8
	state += 1
	if state > 2:
		state = 0
	await get_tree().create_timer(speed).timeout
	dancing()
	pass
