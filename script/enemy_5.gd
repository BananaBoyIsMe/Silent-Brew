extends Node2D

var player_detected = false
var tentacle = false

var base_scale := Vector2.ONE
var idle_time := 0.0
var idle_strength := 0.03
var idle_speed := 2.5

var idle_timex := 0.0
var idle_strengthx := 0.03
var idle_speedx := 2.0

var rng = RandomNumberGenerator.new()

@onready var sprite := $Sprite2D

@onready var enemy_area = $detect

func _on_detect_area_entered(area: Area2D) -> void:
	if area.name == "player":
		player_detected = true

func _on_detect_area_exited(area: Area2D) -> void:
	if area.name == "player":
		player_detected = false

func _ready() -> void:
	#if sprite.texture:
		#sprite.pivot_offset = sprite.texture.get_size() * 0.5
	scale = Vector2(1, 0)
	#centered = true 
	#pivot_offset = Vector2(width/2, height/2)
	#base_scale = scale
	#loop()
	
	idle_time = randf_range(0, 1)
	idle_strength = randf_range(0.02, 0.08)
	idle_speed = randf_range(1, 3)
	
	idle_timex = randf_range(0, 1)
	idle_strengthx = randf_range(0.02, 0.08)
	idle_speedx = randf_range(1, 3)
	
	global.connect("turn_changed", new_turn)

func new_turn() -> void:
	if player_detected:
		if tentacle:
			attack()
		tentacle_rise()
	else:
		tentacle_gone()

func tentacle_rise() -> void:
	tentacle = true
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)

func tentacle_gone() -> void:
	tentacle = false
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 0), 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)

func attack() -> void:
	enemy_area.name = "enemy"
	await get_tree().create_timer(0.1).timeout
	enemy_area.name = "detect"

#func loop() -> void:
	#var target_scale := randf_range(0.9, 1.1)
#
	#var tween := create_tween()
	#tween.tween_property(self, "scale", Vector2(target_scale, target_scale), 0.4)\
		#.set_trans(Tween.TRANS_SINE)\
		#.set_ease(Tween.EASE_IN_OUT)
#
	## Wait for animation to finish
	#await tween.finished
#
	## Small pause before next variation
	#await get_tree().create_timer(randf_range(0.2, 0.8)).timeout
#
	## Loop again
	#loop()

func _physics_process(delta: float) -> void:
	idle_time += delta * idle_speed
	var anim := sin(idle_time)
	sprite.scale.y = base_scale.y * (1.0 + anim * idle_strength)
	
	idle_timex += delta * idle_speedx
	var animx := sin(idle_timex)
	sprite.scale.x = base_scale.x * (1.0 + animx * idle_strengthx)
