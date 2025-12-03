extends Node2D

@onready var obj_bt = $Button
@onready var panel = $Button/Panel
@onready var objective_text = $Button/RichTextLabel

var panelhere = false

func _ready() -> void:
	global.connect("in_game_toggled", move_in)
	global.connect("current_room_change", change_objective)
	#panel.visible = false
	#panel.modulate.a = 0.0

func change_objective(new_level: int) -> void:
	match new_level:
		0:
			objective_text.text = "❑ Click and hold to move to other tiles.\n\n❑ Pick up and eat a berry.\n\n❑ Walk into the rainbow fog."
		1:
			objective_text.text = "❑ Click and hold to move to other tiles.\n\n❑ Pick up and eat a berry.\n\n❑ Walk into the rainbow fog."
		2:
			objective_text.text = "❑ Get to the rainbow fog."
		3:
			objective_text.text = "❑ Investigate the footprint.\n\n❑ Get to the rainbow fog."
		4:
			objective_text.text = "❑ Get to the rainbow fog."
		5:
			objective_text.text = "❑ Get to the rainbow fog."
		6:
			objective_text.text = "❑ Get to granny's house.\n\n❑ Investigate granny's flowers"
		7:
			objective_text.text = "❑ Investigate granny's house.\n\n❑ Get to the rainbow fog."
		8:
			objective_text.text = "❑ Get to the rainbow fog."
		9:
			objective_text.text = "❑ Walk on lily pad.\n\n❑ Get to the rainbow fog."
		10:
			objective_text.text = "❑ Investigate the big vine tree.\n\n❑ Get to the rainbow fog."
		11:
			objective_text.text = "❑ Talk to Uncle Nord."
		12:
			objective_text.text = "❑ Get to the rainbow fog."
		13:
			objective_text.text = "❑ Get to the rainbow fog.\n\n❑ Survive."
		14:
			objective_text.text = "❑ Get to the rainbow fog.\n\n❑ Survive."
		15:
			objective_text.text = "❑ Enjoy your victory!"

func move_in(state: bool) -> void:
	var tween = create_tween()
	if state:
		tween.tween_property(obj_bt, "position:x", 1850.0, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	else:
		tween.tween_property(obj_bt, "position:x", 1930.0, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)

func inorout()->void:
	var tween = create_tween()
	#var tween2 = create_tween()
	if panelhere:
		tween.tween_property(obj_bt, "position:x", 1850, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		#tween2.tween_property(panel, "position:x", 1910, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		await tween.finished
		panelhere = false
	else:
		tween.tween_property(obj_bt, "position:x", 1550, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		#tween2.tween_property(panel, "position:x", 1910 - 250, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		await tween.finished
		panelhere = true

func _on_button_button_down() -> void:
	inorout()


func _on_panel_2_mouse_entered() -> void:
	panelhere = false
	inorout()


func _on_panel_2_mouse_exited() -> void:
	panelhere = true
	inorout()
