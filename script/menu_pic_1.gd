extends Node2D

@onready var sprite_material = $SbMenu.material  # Replace with your sprite node path
var saturation = 1  # Default saturation
var decay_rate = 1.3  # How fast saturation fades when stopping
var increase_rate = 2.0  # How fast saturation increases on movement
var last_mouse_move_time = 0.0

var velocity = 10000
var ran_ro = 0
var dir = Vector2(0, 0)
var rng = RandomNumberGenerator.new()

#var once = false

func _ready():
	if sprite_material:
		sprite_material.set("shader_parameter/saturation", saturation)

func _input(event):
	#print(event)
	if event is InputEventMouseMotion:
		saturation = min(1.0, saturation + increase_rate * get_process_delta_time())  # Increase saturation
		last_mouse_move_time = Time.get_ticks_msec()
	if event is InputEventMouseMotion and velocity < 1000:
		#velocity = randi_range(2000, 9000)
		velocity += 500
		dir.x += rng.randf_range(-0.9, 0.9)
		if sign(dir.x) == 1:
			dir.x = clamp(dir.x, 0.1, 0.9)
		else:
			dir.x = clamp(dir.x, -0.9, -0.1)
		dir.y += rng.randf_range(-0.9, 0.9)
		if sign(dir.y) == 1:
			dir.y = clamp(dir.y, 0.1, 0.9)
		else:
			dir.y = clamp(dir.y, -0.9, -0.1)
		ran_ro += rng.randf_range(max(-3 * event.relative.length(), -30), min(3 * event.relative.length(), 30))
		if sign(ran_ro) == 1:
			ran_ro = clamp(ran_ro, 10, 30)
		else:
			ran_ro = clamp(ran_ro, -30, -10)
		#once = false
		
	pass

func _physics_process(delta: float) -> void:
	#print(position)
	
	#print(velocity)
	#print(Time.get_ticks_msec())
	if Time.get_ticks_msec() - last_mouse_move_time > 100:  # If mouse hasn't moved for 0.2s
		saturation = max(0.05, saturation - decay_rate * delta)  # Gradually lower saturation
		#once = true
	
	position += Vector2(dir.x,  dir.y) * (velocity) * delta * 0.03
	rotation_degrees += ran_ro * delta
	
	if velocity > 0:
		velocity -= abs(velocity/50)
	
	if ran_ro > 0:
		ran_ro -= abs(ran_ro/50)
	elif ran_ro < 0:
		ran_ro += abs(ran_ro/50)
	
	if sprite_material:
		sprite_material.set("shader_parameter/saturation", saturation)
