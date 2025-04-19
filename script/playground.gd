extends Node2D

var rng = RandomNumberGenerator.new()
@onready var camera = $Camera2D
@onready var spawn_zoom = $spawn_zoom

#func _ready() -> void:
	#pass # Replace with function body.
#
#func _physics_process(_delta: float) -> void:
	#pass

const MIN_ZOOM = 0.5
const MAX_ZOOM = 3.0
const ZOOM_SPEED = 0.04

func _input(event):
	#zooming code
	#print(event)
	
	if event is InputEventPanGesture:
		spawn_zoom.scale += Vector2( -event.delta.y * ZOOM_SPEED, -event.delta.y * ZOOM_SPEED)
		spawn_zoom.scale.x = clamp(spawn_zoom.scale.x, MIN_ZOOM, MAX_ZOOM)
		spawn_zoom.scale.y = clamp(spawn_zoom.scale.y, MIN_ZOOM, MAX_ZOOM)
	
	#panning code
	if event is InputEventMouseMotion and event.button_mask == 1 and event.pressure == 1.00:
		spawn_zoom.position += event.relative
