extends Node2D

@onready var sun1 = $SbSun1
@onready var sun2 = $SbSun2
@onready var moon1 = $SbMoon1
@onready var label = $Label

func _ready() -> void:
	spin()

func _physics_process(_delta: float) -> void:
	label.text = "Level: " + str(global.current_room) + "\nTurn: " + str(global.turn)

func time_change(id: int) -> void:
	match id:
		0:
			sun1.visible = true
			sun2.visible = true
			moon1.visible = false
		1:
			sun1.visible = false
			sun2.visible = false
			moon1.visible = true

func spin() -> void:
	var tween1 = create_tween()
	tween1.tween_property(sun1, "rotation_degrees", 10, 4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	var tween2 = create_tween()
	tween2.tween_property(sun2, "rotation_degrees", -10, 4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	var tween3 = create_tween()
	tween3.tween_property(moon1, "rotation_degrees", 10, 4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await get_tree().create_timer(4).timeout
	tween1 = create_tween()
	tween1.tween_property(sun1, "rotation_degrees", -10, 4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween2 = create_tween()
	tween2.tween_property(sun2, "rotation_degrees", 10, 4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween3 = create_tween()
	tween3.tween_property(moon1, "rotation_degrees", -10, 4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await get_tree().create_timer(4).timeout
	spin()
