extends Node2D

@onready var return_bt = $return
var gone = true

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	gone = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and !gone:
		gone = true
		get_parent().get_node("paused").back_to_menu_credits()
		return_bt.disabled = true

func _on_return_button_up() -> void:
	audio.play_button()
	if gone:
		return
	gone = true
	get_parent().get_node("paused").back_to_menu_credits()
	return_bt.disabled = true
