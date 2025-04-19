extends RigidBody2D

@onready var sprite_material = $SbMenu.material  # Access SbMenu's material
var saturation = 1.0  # Default saturation
var decay_rate = 1.3  # How fast saturation fades when stopping
var increase_rate = 2.0  # How fast saturation increases on movement
var last_mouse_move_time = 0.0

var speed = 10000.0  # Movement force
var ran_ro = 0.0  # Random rotation speed
var dir = Vector2(0, 0)  # Initial movement direction
var rng = RandomNumberGenerator.new()

# Physics properties (simulating friction)
var friction = 0.98  # Linear friction (reduces velocity over time)
var angular_friction = 0.95  # Rotation friction (reduces rotation over time)

var once = false

func _ready():
	#process_mode = Node.PROCESS_MODE_ALWAYS
	if sprite_material:
		sprite_material.set("shader_parameter/saturation", saturation)

func _input(event):
	if event is InputEventMouseMotion:
		# Increase saturation when moving the mouse
		saturation = min(1.0, saturation + increase_rate * get_process_delta_time())
		last_mouse_move_time = Time.get_ticks_msec()
		#speed += 50

		# Apply random movement and rotation
		if speed < 1000:
			rng.seed = hash(position.x)
			speed += 500
			# Adjust movement direction randomly
			dir.x += rng.randf_range(-0.9, 0.9)
			dir.x = clamp(dir.x, -0.9, 0.9)

			dir.y += rng.randf_range(-0.9, 0.9)
			dir.y = clamp(dir.y, -0.9, 0.9)

			# Add random rotation
			ran_ro += rng.randf_range(-60, 60)
			ran_ro = clamp(ran_ro, -60, 60)

			# Apply an impulse in the new direction
			apply_impulse(dir.normalized() * speed * 0.01)
			#once = false
		#print(position)

func _physics_process(delta):
	#if get_tree().paused:
		#PhysicsServer2D.step(delta)
	#process_mode = Node.PROCESS_MODE_ALWAYS
	# Reduce saturation over time when idle
	if Time.get_ticks_msec() - last_mouse_move_time > 200:
		saturation = max(0.05, saturation - decay_rate * delta)
		#once = true

	linear_velocity *= friction
	angular_velocity *= angular_friction
	ran_ro = lerp(float(ran_ro), 0.0, 0.02)  # Smoothly reduce rotation effect
	speed = lerp(float(speed), 0.0, 0.1)  # Smoothly reduce rotation effect

	apply_torque_impulse(ran_ro * 5)

	if sprite_material:
		sprite_material.set("shader_parameter/saturation", saturation)
