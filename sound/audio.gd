extends Node2D

#@export var mute: bool = false
#var time_left = 118
#
#func _physics_process(delta: float) -> void:
	#time_left -= delta
	#if time_left <= 0:
		#time_left = 118
		#play_menu()

func stop_all():
	$room1.stop()
	$menu.stop()
	$walking.stop()
	$dark_cave.stop()
	$button.stop()
	$died.stop()
	$portal.stop()
	$lava.stop()
	$bird_forest.stop()
	$beach.stop()

func _ready():
	play_menu()

func play_menu():
	if global.volume_mute[0] or global.volume_mute[1]:
		return
	$menu.play()

func play_room1():
	if global.volume_mute[0] or global.volume_mute[1]:
		return
	$room1.play()

func play_walking():
	if global.volume_mute[0] or global.volume_mute[3]:
		return
	$walking.play()

func play_cave():
	if global.volume_mute[0] or global.volume_mute[2]:
		return
	$dark_cave.play()

func play_button():
	if global.volume_mute[0] or global.volume_mute[3]:
		return
	$button.play()

func play_died():
	if global.volume_mute[0] or global.volume_mute[3]:
		return
	$died.play()

func play_portal():
	if global.volume_mute[0] or global.volume_mute[3]:
		return
	$portal.play()

func play_lava():
	if global.volume_mute[0] or global.volume_mute[2]:
		return
	$lava.play()

func play_bird_forest():
	if global.volume_mute[0] or global.volume_mute[2]:
		return
	$bird_forest.play()

func play_beach():
	if global.volume_mute[0] or global.volume_mute[2]:
		return
	$beach.play()
