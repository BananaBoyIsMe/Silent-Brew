extends Area2D

var undo = false

func _on_area_entered(area: Area2D) -> void:
	undo = false
	await get_tree().create_timer(0.8).timeout
	
	if area.name == "player" and !undo:
		global.emit_signal("add_inventory", "black_berry")
		global.inv_on = true

func _on_area_exited(area: Area2D) -> void:
	undo = true
