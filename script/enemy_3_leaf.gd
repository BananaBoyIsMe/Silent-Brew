extends Node2D

# Motion parameters
@export var speed: float = 350.0           # movement speed
@export var base_amplitude: float = 5.0    # curve height
@export var direction: Vector2 = Vector2.RIGHT  # movement direction (normalized)
var start_position: Vector2

var count_turn := 0
var stop := false
var t := 0.0
var new_t := 0.0

func _ready():
	start_position = position
	global.connect("turn_changed", new_turn_changed)
	
	# Normalize direction to avoid scaling issues
	direction = direction.normalized()

func new_turn_changed(_new_turn) -> void:
	count_turn += 1
	if count_turn == 6:
		var tween = create_tween()
		tween.tween_property(self, "modulate:a", 0, 1)
	stop = true
	new_t = t

func _physics_process(delta: float) -> void:
	if global.move_now:
		t += delta
	elif new_t < t:
		t -= delta

	# Combine multiple sine waves for smooth, natural curves
	var curve_offset = base_amplitude * sin(TAU * 0.5 * t)
	curve_offset += (base_amplitude * 0.5) * sin(TAU * 1.3 * t + 1)
	curve_offset += (base_amplitude * 0.3) * sin(TAU * 2.1 * t + 2)
	curve_offset += randf_range(-0.5, 0.5)  # subtle random variation

	# Movement base position
	var move = direction * speed * t

	# Apply perpendicular offset for "curvy" path
	var perpendicular = Vector2(-direction.y, direction.x)
	var offset = perpendicular * curve_offset

	# Update final position
	position = start_position + move + offset
