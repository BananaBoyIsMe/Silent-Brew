extends Node2D

var rng = RandomNumberGenerator.new()

var leaf = preload("res://scene/enemy/enemy_3_leaf.tscn")

func _ready() -> void:
	global.connect("turn_changed", go_turn_change)

func go_turn_change(_new_turn) -> void:
	for i in randi_range(1, 4):
		var new_leaf = leaf.instantiate()
		#new_leaf.position = self.position
		new_leaf.rotation_degrees = randf_range(0, 360)
		new_leaf.direction = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1)).normalized()
		var ran_size = randf_range(0.5, 1.2)
		new_leaf.scale = Vector2(ran_size, ran_size)
		add_child(new_leaf)
		pass
