extends Node2D

@onready var hp_text = $Label
@onready var heart1 = $heart_progress
@onready var heart2 = $heart_progress2
@onready var heart3 = $heart_progress3

func _ready() -> void:
	global.connect("player_cur_health_toggled", health_change)
	global.connect("turn_changed", health_drain)
	hp_text.text = str(global.player_cur_health) + "/" + str(global.player_max_health) + " hp"

func health_drain(_turn) -> void:
	global.player_cur_health -= 1

func health_change(new_health) -> void:
	if new_health > 30:
		global.player_cur_health = 30
		#return
	
	hp_text.text = str(global.player_cur_health) + "/" + str(global.player_max_health) + " hp"
	if new_health > 20:
		heart1.value = global.player_cur_health - 20
		heart2.value = 10
		heart3.value = 10
	elif new_health > 10:
		heart1.value = 0
		heart2.value = global.player_cur_health - 10
		heart3.value = 10
	elif new_health > 0:
		heart1.value = 0
		heart2.value = 0
		heart3.value = global.player_cur_health
	elif new_health <= 0:
		heart1.value = 0
		heart2.value = 0
		heart3.value = 0
		global.player_lost = true
		global.in_cutscene = true
		hp_text.text = "0/" + str(global.player_max_health) + " hp"
