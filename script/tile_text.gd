extends Node2D

func _ready() -> void:
	position.x -= 10
	position.y -= 20
	var tween = create_tween()
	tween.tween_property(self, "position:y", self.position.y - 90, 3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	
	#print("Hi")
	
	var tween1 = create_tween()
	tween1.tween_property(self, "modulate:a", 1, 0.5)
	await get_tree().create_timer(1.2).timeout
	var tween2 = create_tween()
	tween2.tween_property(self, "modulate:a", 0, 1.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await tween2.finished
	self.queue_free()
