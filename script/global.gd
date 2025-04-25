extends Node

var player = null
var player_des_pos = Vector2(0, 0)
var player_des_real_pos = Vector2(0, 0)
var player_last_pos = Vector2(0, 0)
var player_cur_pos = Vector2(0, 0)
var player_direction = [Vector2(0, 0)]
var player_direction_real_pos = []
var player_direction_num = 1

var in_cutscene = true

var move_timer = 0

var in_game = false

var inventory_list_id = [0, 0, 0, 0, 0, 0, 0]
var inventory_list_obj = [0, 0, 0, 0, 0, 0, 0]
var dragging_item = false

var volume = [0.8, 0.8, 0.8, 0.8]
var volume_mute = [false, false, false, false]

var temp_room = []
var temp_enemy = []

var cur_book_page = 1

var inventory_on = false

signal move_on_toggled(state: bool)
signal book_toggled(state: bool)
signal map_toggled(state: bool)

#var move_now = false

var move_now: bool = false: 
	set(value):
		if move_now != value:
			move_now = value
			emit_signal("move_on_toggled", move_now)

var book_on: bool = false: 
	set(value):
		if book_on != value:
			book_on = value
			emit_signal("book_toggled", book_on)

var map_on: bool = false: 
	set(value):
		if map_on != value:
			map_on = value
			emit_signal("map_toggled", map_on)

var encyclopedia_on = false

var turn = 0

var room1 = [Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), 
			Vector2(2, 0), Vector2(2, 1), Vector2(2, 2), Vector2(2, 3), Vector2(2, 4), Vector2(2, 5),
			Vector2(3, 0), Vector2(3, 1), Vector2(3, 2), Vector2(3, 3), Vector2(3, 4), Vector2(3, 5),
			Vector2(4, 1), Vector2(4, 2), Vector2(4, 3), Vector2(4, 4), Vector2(4, 5),
			Vector2(5, 1), Vector2(5, 2), Vector2(5, 3), Vector2(5, 4), Vector2(5, 5),
			Vector2(6, 2), Vector2(6, 3), Vector2(6, 4), Vector2(6, 5), Vector2(6, 6), 
			Vector2(7, 1), Vector2(7, 2), Vector2(7, 3), Vector2(7, 4), Vector2(7, 5), Vector2(7, 6),
			Vector2(8, 3), Vector2(8, 4), Vector2(8, 5), Vector2(8, 6),
			Vector2(9, 4), Vector2(9, 5), Vector2(9, 6),
			Vector2(10, 5), Vector2(10, 6), Vector2(10, 7),
			Vector2(11, 6),
			Vector2(12, 7),]

var room1_dict = {
	Vector2(1, 0): true,
	Vector2(1, 1): true,
	Vector2(1, 2): true,
	Vector2(2, 0): true,
	Vector2(2, 1): true,
	Vector2(2, 2): true,
	Vector2(2, 3): true,
	Vector2(2, 4): true,
	Vector2(2, 5): true,
	Vector2(3, 0): true,
	Vector2(3, 1): true,
	Vector2(3, 2): true,
	Vector2(3, 3): true,
	Vector2(3, 4): true,
	Vector2(3, 5): true,
	Vector2(4, 1): true,
	Vector2(4, 2): true,
	Vector2(4, 3): true,
	Vector2(4, 4): true,
	Vector2(4, 5): true,
	Vector2(5, 1): true,
	Vector2(5, 2): true,
	Vector2(5, 3): true,
	Vector2(5, 4): true,
	Vector2(5, 5): true,
	Vector2(6, 2): true,
	Vector2(6, 3): true,
	Vector2(6, 4): true,
	Vector2(6, 5): true,
	Vector2(6, 6): true,
	Vector2(7, 1): true,
	Vector2(7, 2): true,
	Vector2(7, 3): true,
	Vector2(7, 4): true,
	Vector2(7, 5): true,
	Vector2(7, 6): true,
	Vector2(8, 3): true,
	Vector2(8, 4): true,
	Vector2(8, 5): true,
	Vector2(8, 6): true,
	Vector2(9, 4): true,
	Vector2(9, 5): true,
	Vector2(9, 6): true,
	Vector2(10, 5): true,
	Vector2(10, 6): true,
	Vector2(10, 7): true,
	Vector2(11, 6): true,
	Vector2(12, 7): true,
}

#var room1_dict_deco = {
	#Vector2(0, 0): ["g1", "g2"],
	#Vector2(1, 0): ["g2"],
	#Vector2(2, 0): ["g3", "r1"],
	#Vector2(3, 0): ["g2", "g3"],
	#Vector2(1, 1): ["r2"],
	#Vector2(2, 1): ["r1", "g1", "g3"],
	#Vector2(3, 1): [],
	#Vector2(4, 1): ["g3"],
	#Vector2(1, 2): ["g3", "g2"],
	#Vector2(2, 2): ["g2"],
	#Vector2(3, 2): ["g1", "g2"],
	#Vector2(4, 2): ["r2"],
	#Vector2(5, 2): ["g1", "g2", "g1"],
	#Vector2(1, 3): ["g1"],
	#Vector2(2, 3): ["r4"],
	##Vector2(3, 3): true,
	##Vector2(4, 3): true,
	#Vector2(5, 3): ["g1", "g2", "g1"],
	#Vector2(2, 4): ["g2"],
	#Vector2(3, 4): ["g3"],
	#Vector2(4, 4): [],
	#Vector2(5, 4): ["r3", "g2", "g1"],
	#Vector2(6, 4): ["r1"],
	#Vector2(3, 5): ["g2"],
	#Vector2(4, 5): ["g3", "g1"],
	#Vector2(5, 5): ["g1"],
	#Vector2(6, 5): ["g1", "r3"],
	#Vector2(7, 5): ["g2", "g1"],
	#Vector2(4, 6): ["g3"],
	#Vector2(5, 6): ["g1", "g2"],
	#Vector2(6, 6): ["g2", "g2"],
	#Vector2(7, 6): ["r1", "r4"],
	#Vector2(8, 6): ["g1", "g1"],
	#Vector2(6, 7): ["r2", "g3"],
	#Vector2(7, 7): [],
	#Vector2(8, 7): ["g1", "g1", "r2"],
	#Vector2(9, 7): ["g3"],
	#Vector2(10, 7): ["g2", "g3"],
	#Vector2(11, 7): ["r1", "g1"],
	#Vector2(12, 7): ["g1"],
	#Vector2(13, 7): ["g1", "g1", "g2"],
	#Vector2(12, 6): ["r3", "r1", "g3"],
	#Vector2(13, 6): ["g2", "g1",],
	#Vector2(6, 8): ["g2"],
	#Vector2(7, 8): [],
	#Vector2(8, 8): ["g1", "g1"],
	#Vector2(9, 8): ["r1", "g3", "g1"],
	#Vector2(10, 8): ["g1"],
	#Vector2(11, 8): ["g3", "g1"],
	#Vector2(12, 8): ["r2", "g1"],
	#Vector2(13, 8): ["r4"],
	#Vector2(14, 7): ["r3", "g3"],
	#Vector2(14, 6): []
#}
#
#var room1_dict_enemy = {
	#Vector2(14, 6): 1
#}

#
var room2 = [ Vector2(0, 1), Vector2(0, 2), Vector2(0, 6), Vector2(0, 7),
			Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), Vector2(1, 3), Vector2(1, 4), Vector2(1, 5), Vector2(1, 6), Vector2(1, 7),
			Vector2(2, 1), Vector2(2, 2), Vector2(2, 3), Vector2(2, 4), Vector2(2, 5), Vector2(2, 6),
			Vector2(3, 0), Vector2(3, 1), Vector2(3, 2),
			Vector2(4, 1), Vector2(4, 2), Vector2(4, 3), Vector2(4, 4),
			Vector2(5, 1), Vector2(5, 2), Vector2(5, 3), Vector2(5, 4), Vector2(5, 5),
			Vector2(6, 3), Vector2(6, 4), Vector2(6, 5), Vector2(6, 6), 
			Vector2(7, 2), Vector2(7, 3), Vector2(7, 4), Vector2(7, 5), Vector2(7, 6),
			Vector2(8, 1), Vector2(8, 2), Vector2(8, 3), Vector2(8, 4), Vector2(8, 5),
			Vector2(9, 0), Vector2(9, 1), Vector2(9, 2),
			Vector2(10, 1), Vector2(10, 2), Vector2(10, 3),
			Vector2(11, 0), Vector2(11, 1), Vector2(11, 2), Vector2(11, 3), Vector2(11, 4),
			Vector2(12, 1), Vector2(12, 2), Vector2(12, 3), Vector2(12, 4),
			Vector2(13, 2), Vector2(13, 3),
			]

var room2_dict = {
	Vector2(0, 1): true,
	Vector2(0, 2): true,
	Vector2(0, 6): true,
	Vector2(0, 7): true,
	Vector2(1, 0): true,
	Vector2(1, 1): true,
	Vector2(1, 2): true,
	Vector2(1, 3): true,
	Vector2(1, 4): true,
	Vector2(1, 5): true,
	Vector2(1, 6): true,
	Vector2(1, 7): true,
	Vector2(2, 1): true,
	Vector2(2, 2): true,
	Vector2(2, 3): true,
	Vector2(2, 4): true,
	Vector2(2, 5): true,
	Vector2(2, 6): true,
	Vector2(3, 0): true,
	Vector2(3, 1): true,
	Vector2(3, 2): true,
	Vector2(4, 1): true,
	Vector2(4, 2): true,
	Vector2(4, 3): true,
	Vector2(4, 4): true,
	Vector2(5, 1): true,
	Vector2(5, 2): true,
	Vector2(5, 3): true,
	Vector2(5, 4): true,
	Vector2(5, 5): true,
	Vector2(6, 3): true,
	Vector2(6, 4): true,
	Vector2(6, 5): true,
	Vector2(6, 6): true,
	Vector2(7, 2): true,
	Vector2(7, 3): true,
	Vector2(7, 4): true,
	Vector2(7, 5): true,
	Vector2(7, 6): true,
	Vector2(8, 1): true,
	Vector2(8, 2): true,
	Vector2(8, 3): true,
	Vector2(8, 4): true,
	Vector2(8, 5): true,
	Vector2(9, 0): true,
	Vector2(9, 1): true,
	Vector2(9, 2): true,
	Vector2(10, 1): true,
	Vector2(10, 2): true,
	Vector2(10, 3): true,
	Vector2(11, 0): true,
	Vector2(11, 1): true,
	Vector2(11, 2): true,
	Vector2(11, 3): true,
	Vector2(11, 4): true,
	Vector2(12, 1): true,
	Vector2(12, 2): true,
	Vector2(12, 3): true,
	Vector2(12, 4): true,
	Vector2(13, 2): true,
	Vector2(13, 3): true,
}

#var room2_dict_deco = {
	#Vector2(3, 0): ["r1", "g1", "g2", "g3"],
	#Vector2(4, 0): ["r2", "g1", "g3"],
	#Vector2(3, 1): ["g3", "g1"],
	#Vector2(4, 1): ["g2", "g1", "g3"],
	#Vector2(6, 1): ["g1", "g1", "r4"],
	#Vector2(3, 2): [],
	#Vector2(4, 2): ["r2", "r3", "r4"],
	#Vector2(5, 2): ["g1", "g3", "g3"],
	#Vector2(6, 2): ["g1", "g3"],
	#Vector2(3, 3): ["g2"],
	#Vector2(4, 3): ["g2", "g2", "r2"],
	#Vector2(5, 3): ["r4", "r4", "g3"],
	#Vector2(6, 3): ["r2", "g1", "g3"],
	#Vector2(7, 3): ["r1", "r2"],
	#Vector2(10, 3): ["g1", "r3"],
	#Vector2(2, 4): ["g1", "g2"],
	#Vector2(3, 4): ["g2"],
	#Vector2(4, 4): ["g1", "r1", "r3", "g1"],
	#Vector2(5, 4): ["g1", "g2"],
	#Vector2(6, 4): ["r2", "g3"],
	#Vector2(7, 4): ["r1", "g1"],
	#Vector2(8, 4): ["r3"],
	#Vector2(9, 4): ["r4", "g1", "g2", "r1"],
	#Vector2(10, 4): ["r1", "g3", "r1"],
	#Vector2(2, 5): ["g2", 'r2'],
	#Vector2(3, 5): ["g1", "g1"],
	#Vector2(4, 5): ["r3"],
	#Vector2(5, 5): ["g1", "g3"],
	#Vector2(6, 5): ["g3"],
	#Vector2(7, 5): [],
	#Vector2(8, 5): ["g3", "r2", "r4"],
	#Vector2(9, 5): ["r1", "r2"],
	#Vector2(10, 5): ["g2", "r2", "r1"],
	#Vector2(2, 6): ["r1", "g1"],
	#Vector2(3, 6): ["r1"],
	#Vector2(4, 6): ["g1", "g2"],
	#Vector2(5, 6): ["g3"],
	#Vector2(6, 6): ["r2"],
	#Vector2(7, 6): [],
	#Vector2(8, 6): ["r3", "g1"],
	#Vector2(9, 6): ["g1"],
	#Vector2(10, 6): ["g3", "g1", "r1"],
	#Vector2(3, 7): ["r1"],
	#Vector2(4, 7): ["g1"],
	#Vector2(5, 7): ["g2", "g1"],
	#Vector2(6, 7): ["g2"],
	#Vector2(7, 7): ["r3"],
	#Vector2(8, 7): ["r1", "g3"],
	#Vector2(9, 7): [],
	#Vector2(3, 8): ["r1", "g2"],
	#Vector2(4, 8): ["r2", "r1"],
	#Vector2(5, 8): ["g1"],
	#Vector2(6, 8): [],
	#Vector2(7, 8): ["g2"],
	#Vector2(8, 8): ["r4", "g1"],
	#Vector2(9, 8): ["g3"],
	#Vector2(3, 9): [],
	#Vector2(4, 9): [],
	#Vector2(5, 9): [],
	#Vector2(6, 9): [],
	#Vector2(7, 9): [],
	#Vector2(8, 9): [],
	#Vector2(9, 9): [],
	#Vector2(10, 9): [],
	#Vector2(3, 10): [],
	#Vector2(4, 10): [],
	#Vector2(5, 10): [],
	#Vector2(6, 10): [],
	#Vector2(7, 10): [],
	#Vector2(8, 10): [],
	#Vector2(3, 11): [],
	#Vector2(4, 11): [],
	#Vector2(5, 11): [],
	#Vector2(6, 11): [],
	#Vector2(7, 11): [],
	#Vector2(3, 12): [],
	#Vector2(4, 12): [],
	#Vector2(5, 12): [],
	#Vector2(6, 12): [],
	#Vector2(7, 12): [],
	#Vector2(8, 12): [],
	#Vector2(2, 13): [],
	#Vector2(3, 13): [],
	#Vector2(4, 13): [],
	#Vector2(5, 13): [],
	#Vector2(6, 13): [],
	#Vector2(7, 13): [],
	#Vector2(8, 13): [],
	#Vector2(9, 13): [],
	#Vector2(2, 14): [],
	#Vector2(3, 14): [],
	#Vector2(4, 14): [],
	#Vector2(5, 14): [],
	#Vector2(6, 14): [],
	#Vector2(7, 14): [],
	#Vector2(8, 14): [],
	#Vector2(9, 14): [],
	#Vector2(3, 15): [],
	#Vector2(4, 15): [],
	#Vector2(5, 15): [],
	#Vector2(6, 15): [],
	#Vector2(7, 15): [],
	#Vector2(8, 15): [],
	#Vector2(9, 15): [],
	#Vector2(4, 16): [],
	#Vector2(5, 16): [],
	#Vector2(6, 16): [],
	#Vector2(7, 16): [],
	#Vector2(8, 16): [],
	#Vector2(2, 17): [],
	#Vector2(3, 17): [],
	#Vector2(4, 17): [],
	#Vector2(5, 17): [],
	#Vector2(6, 17): [],
	#Vector2(7, 17): [],
	#Vector2(4, 18): [],
	#Vector2(5, 18): [],
	#Vector2(6, 18): [],
	#Vector2(7, 18): [],
	#Vector2(8, 18): [],
	#Vector2(4, 19): [],
	#Vector2(5, 19): [],
	#Vector2(7, 19): [],
	#Vector2(8, 19): [],
	#Vector2(4, 20): [],
	#Vector2(5, 20): [],
	#Vector2(8, 20): [],
	#Vector2(9, 20): [],
	#Vector2(4, 21): [],
	#Vector2(5, 21): [],
	#Vector2(3, 22): [],
	#Vector2(4, 22): [],
	#Vector2(5, 22): [],
	#Vector2(6, 22): [],
	#Vector2(3, 23): [],
	#Vector2(5, 23): [],
#}
#
#var room2_dict_enemy = {
	##Vector2(14, 6): 1
#}

var room3 = [ Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), Vector2(1, 3), Vector2(1, 4), Vector2(1, 5), Vector2(1, 6), Vector2(1, 7),
			Vector2(2, 0), Vector2(2, 1), Vector2(2, 2), Vector2(2, 3), Vector2(2, 4), Vector2(2, 5), Vector2(2, 6), Vector2(2, 7),
			Vector2(3, 0), Vector2(3, 1), Vector2(3, 2), Vector2(3, 3), Vector2(3, 4), Vector2(3, 5), Vector2(3, 6), Vector2(3, 7),
			Vector2(4, 1), Vector2(4, 2), Vector2(4, 3), Vector2(4, 4), Vector2(4, 5), Vector2(4, 6), Vector2(4, 7),
			Vector2(5, 1), Vector2(5, 2), Vector2(5, 3), Vector2(5, 4), Vector2(5, 5), Vector2(5, 6), Vector2(5, 7),
			Vector2(6, 1), Vector2(6, 2), Vector2(6, 3), Vector2(6, 4), Vector2(6, 5), Vector2(6, 6), Vector2(6, 7),
			Vector2(7, 0), Vector2(7, 1), Vector2(7, 2), Vector2(7, 3), Vector2(7, 4), Vector2(7, 5), Vector2(7, 6), Vector2(7, 7),
			Vector2(8, 1), Vector2(8, 2), Vector2(8, 3), Vector2(8, 4), Vector2(8, 5), Vector2(8, 6), Vector2(8, 7),
			Vector2(9, 0), Vector2(9, 1), Vector2(9, 2), Vector2(9, 3), Vector2(9, 4), Vector2(9, 5), Vector2(9, 6), Vector2(9, 7),
			Vector2(10, 0), Vector2(10, 1), Vector2(10, 2), Vector2(10, 3), Vector2(10, 4), Vector2(10, 5), Vector2(10, 6), Vector2(10, 7),
			Vector2(11, 0), Vector2(11, 1), Vector2(11, 2), Vector2(11, 3), Vector2(11, 4), Vector2(11, 5), Vector2(11, 6), Vector2(11, 7),
			Vector2(12, 1), Vector2(12, 2), Vector2(12, 3), Vector2(12, 4), Vector2(12, 5), Vector2(12, 6), Vector2(12, 7),
			]

var room3_dict = { 
	Vector2(1, 0): true, 
	Vector2(1, 1): true, 
	Vector2(1, 2): true, 
	Vector2(1, 3): true, 
	Vector2(1, 4): true, 
	Vector2(2, 0): true, 
	Vector2(2, 1): true, 
	Vector2(2, 2): true, 
	Vector2(2, 3): true, 
	Vector2(2, 4): true, 
	Vector2(2, 5): true,
	Vector2(3, 0): true, 
	Vector2(3, 1): true, 
	Vector2(3, 2): true, 
	Vector2(3, 3): true, 
	Vector2(3, 4): true, 
	Vector2(4, 1): true, 
	Vector2(4, 2): true, 
	Vector2(4, 3): true, 
	Vector2(4, 4): true, 
	Vector2(4, 5): true, 
	Vector2(5, 1): true, 
	Vector2(5, 2): true, 
	Vector2(5, 3): true, 
	Vector2(5, 4): true, 
	Vector2(5, 5): true, 
	Vector2(6, 1): true, 
	Vector2(6, 2): true, 
	Vector2(6, 3): true, 
	Vector2(6, 4): true, 
	Vector2(6, 5): true, 
	Vector2(7, 0): true, 
	Vector2(7, 1): true, 
	Vector2(7, 2): true, 
	Vector2(7, 3): true, 
	Vector2(7, 4): true, 
	Vector2(7, 5): true, 
	Vector2(8, 1): true, 
	Vector2(8, 2): true, 
	Vector2(8, 3): true, 
	Vector2(8, 4): true, 
	Vector2(8, 5): true, 
	Vector2(9, 0): true, 
	Vector2(9, 1): true, 
	Vector2(9, 3): true, 
	Vector2(9, 4): true, 
	Vector2(10, 0): true, 
	Vector2(10, 1): true, 
	Vector2(10, 3): true, 
	Vector2(10, 4): true, 
	Vector2(11, 0): true, 
	Vector2(11, 1): true, 
	Vector2(11, 2): true, 
	Vector2(11, 3): true, 
	Vector2(11, 4): true, 
	Vector2(12, 1): true, 
	Vector2(12, 2): true, 
	Vector2(12, 3): true, 
	Vector2(12, 4): true,
}

var room4 = [ Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), Vector2(1, 3), Vector2(1, 4), Vector2(1, 5), Vector2(1, 6), 
			Vector2(2, 0), Vector2(2, 1), Vector2(2, 2), Vector2(2, 3), Vector2(2, 4), Vector2(2, 5), Vector2(2, 6), Vector2(2, 7),
			Vector2(3, 1), Vector2(3, 2), Vector2(3, 3), Vector2(3, 4), Vector2(3, 5), Vector2(3, 6), 
			Vector2(4, 2), Vector2(4, 3), Vector2(4, 4), Vector2(4, 5), Vector2(4, 6),
			Vector2(5, 0), Vector2(5, 1), Vector2(5, 2), Vector2(5, 3), Vector2(5, 4), Vector2(5, 5), Vector2(5, 6), 
			Vector2(6, 0), Vector2(6, 1), Vector2(6, 2), Vector2(6, 3), Vector2(6, 4), Vector2(6, 5), Vector2(6, 6), Vector2(6, 7),
			Vector2(7, 0), Vector2(7, 1), Vector2(7, 2), Vector2(7, 3), Vector2(7, 4), Vector2(7, 5), Vector2(7, 6), 
			Vector2(8, 0), Vector2(8, 1), Vector2(8, 2), Vector2(8, 3), Vector2(8, 4), Vector2(8, 5), Vector2(8, 6),
			Vector2(9, 0), Vector2(9, 1), Vector2(9, 2), Vector2(9, 3), Vector2(9, 4), Vector2(9, 5), Vector2(9, 6), 
			Vector2(10, 1), Vector2(10, 2), Vector2(10, 3), Vector2(10, 4), Vector2(10, 5), Vector2(10, 6), 
			Vector2(11, 0), Vector2(11, 1), Vector2(11, 2), Vector2(11, 3), Vector2(11, 4), Vector2(11, 5), Vector2(11, 6), 
			Vector2(12, 0), Vector2(12, 1), Vector2(12, 2), Vector2(12, 3), Vector2(12, 4), Vector2(12, 5), Vector2(12, 7),
			]

var room4_dict = { 
	Vector2(1, 0): true, 
	Vector2(1, 1): true, 
	Vector2(1, 3): true, 
	Vector2(1, 5): true, 
	Vector2(1, 6): true, 
	Vector2(2, 0): true, 
	Vector2(2, 2): true, 
	Vector2(2, 3): true, 
	Vector2(2, 4): true, 
	Vector2(2, 5): true,
	Vector2(2, 6): true,
	Vector2(2, 7): true,
	Vector2(3, 1): true, 
	Vector2(3, 2): true, 
	Vector2(3, 5): true, 
	Vector2(3, 6): true, 
	Vector2(4, 2): true, 
	Vector2(4, 3): true, 
	Vector2(4, 6): true, 
	Vector2(5, 0): true, 
	Vector2(5, 1): true, 
	Vector2(5, 2): true, 
	Vector2(5, 3): true, 
	Vector2(5, 4): true, 
	Vector2(5, 6): true, 
	Vector2(6, 0): true, 
	Vector2(6, 1): true, 
	Vector2(6, 4): true, 
	Vector2(6, 5): true, 
	Vector2(6, 7): true, 
	Vector2(7, 1): true, 
	Vector2(7, 3): true, 
	Vector2(7, 4): true, 
	Vector2(7, 5): true, 
	Vector2(7, 6): true, 
	Vector2(8, 0): true, 
	Vector2(8, 1): true, 
	Vector2(8, 2): true, 
	Vector2(8, 3): true, 
	Vector2(8, 4): true, 
	Vector2(9, 0): true, 
	Vector2(9, 1): true, 
	Vector2(9, 3): true, 
	Vector2(9, 4): true, 
	Vector2(9, 5): true, 
	Vector2(9, 6): true, 
	Vector2(10, 1): true, 
	Vector2(10, 3): true, 
	Vector2(10, 4): true, 
	Vector2(10, 5): true, 
	Vector2(10, 6): true, 
	Vector2(11, 0): true, 
	Vector2(11, 2): true, 
	Vector2(11, 3): true, 
	Vector2(11, 4): true, 
	Vector2(11, 5): true, 
	Vector2(11, 6): true, 
	Vector2(12, 0): true, 
	Vector2(12, 1): true, 
	Vector2(12, 2): true, 
	Vector2(12, 3): true, 
	Vector2(12, 4): true,
	Vector2(12, 5): true,
	Vector2(12, 7): true,
}


var room5 = [ Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), Vector2(1, 3), Vector2(1, 4), Vector2(1, 5), Vector2(1, 6), 
			Vector2(2, 0), Vector2(2, 1), Vector2(2, 2), Vector2(2, 3), Vector2(2, 4), Vector2(2, 5), Vector2(2, 6), Vector2(2, 7),
			Vector2(3, 0), Vector2(3, 1), Vector2(3, 2), Vector2(3, 3), Vector2(3, 4), Vector2(3, 5), Vector2(3, 6), 
			Vector2(4, 0), Vector2(4, 1), Vector2(4, 2), Vector2(4, 3), Vector2(4, 4), Vector2(4, 5), Vector2(4, 6),
			Vector2(5, 0), Vector2(5, 1), Vector2(5, 2), Vector2(5, 3), Vector2(5, 6), 
			Vector2(6, 1), Vector2(6, 2), Vector2(6, 4), Vector2(6, 7),
			Vector2(7, 1), Vector2(7, 4), Vector2(7, 5), Vector2(7, 6), 
			Vector2(8, 1), Vector2(8, 4), Vector2(8, 5), Vector2(8, 6), Vector2(8, 7),
			Vector2(9, 1), Vector2(9, 3), Vector2(9, 4), Vector2(9, 5), Vector2(9, 6), Vector2(9, 7),
			Vector2(10, 1), Vector2(10, 2), Vector2(10, 3), Vector2(10, 4), Vector2(10, 5), Vector2(10, 6), Vector2(10, 7),
			Vector2(11, 0), Vector2(11, 1), Vector2(11, 2), Vector2(11, 3), Vector2(11, 4), Vector2(11, 5), Vector2(11, 6), Vector2(11, 7),
			Vector2(12, 1), Vector2(12, 2), Vector2(12, 3), Vector2(12, 4), Vector2(12, 5), Vector2(12, 6), Vector2(12, 7),
			]

var room5_dict = { 
	Vector2(1, 0): true, 
	Vector2(1, 1): true, 
	Vector2(1, 2): true, 
	Vector2(1, 3): true, 
	Vector2(1, 4): true, 
	Vector2(1, 5): true, 
	Vector2(1, 6): true, 
	Vector2(2, 0): true, 
	Vector2(2, 1): true, 
	Vector2(2, 2): true, 
	Vector2(2, 3): true, 
	Vector2(2, 4): true, 
	Vector2(2, 5): true, 
	Vector2(2, 6): true, 
	Vector2(2, 7): true,
	Vector2(3, 0): true, 
	Vector2(3, 1): true, 
	Vector2(3, 2): true, 
	Vector2(3, 3): true, 
	Vector2(3, 4): true, 
	Vector2(3, 5): true, 
	Vector2(3, 6): true, 
	Vector2(4, 0): true, 
	Vector2(4, 1): true, 
	Vector2(4, 2): true, 
	Vector2(4, 3): true, 
	Vector2(4, 4): true, 
	Vector2(4, 5): true, 
	Vector2(4, 6): true,
	Vector2(5, 0): true, 
	Vector2(5, 1): true, 
	Vector2(5, 2): true, 
	Vector2(5, 3): true, 
	Vector2(5, 6): true, 
	Vector2(6, 1): true, 
	Vector2(6, 2): true, 
	Vector2(6, 4): true, 
	Vector2(6, 7): true,
	Vector2(7, 1): true, 
	Vector2(7, 4): true, 
	Vector2(7, 5): true, 
	Vector2(7, 6): true, 
	Vector2(8, 1): true, 
	Vector2(8, 4): true, 
	Vector2(8, 5): true, 
	Vector2(8, 6): true, 
	Vector2(8, 7): true,
	Vector2(9, 1): true, 
	Vector2(9, 3): true, 
	Vector2(9, 4): true, 
	Vector2(9, 5): true, 
	Vector2(9, 6): true, 
	Vector2(9, 7): true,
	Vector2(10, 1): true, 
	Vector2(10, 2): true, 
	Vector2(10, 3): true, 
	Vector2(10, 4): true, 
	Vector2(10, 5): true, 
	Vector2(10, 6): true, 
	Vector2(10, 7): true,
	Vector2(11, 0): true, 
	Vector2(11, 1): true, 
	Vector2(11, 2): true, 
	Vector2(11, 3): true, 
	Vector2(11, 4): true, 
	Vector2(11, 5): true, 
	Vector2(11, 6): true, 
	Vector2(11, 7): true,
	Vector2(12, 1): true, 
	Vector2(12, 2): true, 
	Vector2(12, 3): true, 
	Vector2(12, 4): true, 
	Vector2(12, 5): true, 
	Vector2(12, 6): true, 
	Vector2(12, 7): true,
}

var room6 = [ Vector2(1, 2), Vector2(1, 3), Vector2(1, 4), Vector2(1, 5), Vector2(1, 6), 
			Vector2(2, 3), Vector2(2, 4), Vector2(2, 5), Vector2(2, 6), Vector2(2, 7),
			Vector2(3, 2), Vector2(3, 3), Vector2(3, 4), Vector2(3, 5), Vector2(3, 6), 
			Vector2(4, 1), Vector2(4, 2), Vector2(4, 3), Vector2(4, 4), Vector2(4, 5), Vector2(4, 6), Vector2(4, 7),
			Vector2(5, 1), Vector2(5, 2), Vector2(5, 3), Vector2(5, 4), Vector2(5, 5), Vector2(5, 6), 
			Vector2(6, 1), Vector2(6, 2), Vector2(6, 3), Vector2(6, 4), Vector2(6, 5), Vector2(6, 6), 
			Vector2(7, 1), Vector2(7, 2), Vector2(7, 3), Vector2(7, 4), Vector2(7, 5), Vector2(7, 6), 
			Vector2(8, 2), Vector2(8, 3), Vector2(8, 4), Vector2(8, 5), Vector2(8, 6), 
			Vector2(9, 3), Vector2(9, 4), Vector2(9, 5), Vector2(9, 6), 
			Vector2(10, 4), Vector2(10, 5), Vector2(10, 6), 
			Vector2(11, 3), Vector2(11, 4), Vector2(11, 5), Vector2(11, 6), 
			Vector2(12, 4), Vector2(12, 5), Vector2(12, 6), 
			]

var room6_dict = { 
	Vector2(1, 2): true, 
	Vector2(1, 3): true, 
	Vector2(1, 4): true, 
	Vector2(1, 5): true, 
	Vector2(1, 6): true, 
	Vector2(2, 3): true, 
	Vector2(2, 4): true, 
	Vector2(2, 5): true, 
	Vector2(2, 6): true, 
	Vector2(2, 7): true,
	Vector2(3, 2): true, 
	Vector2(3, 3): true, 
	Vector2(3, 4): true, 
	Vector2(3, 5): true, 
	Vector2(3, 6): true, 
	Vector2(4, 1): true, 
	Vector2(4, 2): true, 
	Vector2(4, 3): true, 
	Vector2(4, 4): true, 
	Vector2(4, 5): true, 
	Vector2(4, 6): true, 
	Vector2(4, 7): true,
	Vector2(5, 1): true, 
	Vector2(5, 2): true, 
	Vector2(5, 3): true, 
	Vector2(5, 4): true, 
	Vector2(5, 5): true, 
	Vector2(5, 6): true, 
	Vector2(6, 1): true, 
	Vector2(6, 2): true, 
	Vector2(6, 3): true, 
	Vector2(6, 4): true, 
	Vector2(6, 5): true, 
	Vector2(6, 6): true, 
	Vector2(7, 1): true, 
	Vector2(7, 2): true, 
	Vector2(7, 3): true, 
	Vector2(7, 4): true, 
	Vector2(7, 5): true, 
	Vector2(7, 6): true, 
	Vector2(8, 2): true, 
	Vector2(8, 3): true, 
	Vector2(8, 4): true, 
	Vector2(8, 5): true, 
	Vector2(8, 6): true, 
	Vector2(9, 3): true, 
	Vector2(9, 4): true, 
	Vector2(9, 5): true, 
	Vector2(9, 6): true, 
	Vector2(10, 4): true, 
	Vector2(10, 5): true, 
	Vector2(10, 6): true, 
	Vector2(11, 3): true, 
	Vector2(11, 4): true, 
	Vector2(11, 5): true, 
	Vector2(11, 6): true, 
	Vector2(12, 4): true, 
	Vector2(12, 5): true, 
	Vector2(12, 6): true, 
}

var all_room = [null, room1, room2, room3, room4, room5, room6, null]
var all_room_dict = [null, room1_dict, room2_dict, room3_dict, room4_dict, room5_dict, room6_dict, null]

#var all_room_dict_deco = [null, room1_dict_deco, room2_dict_deco]
#var all_room_dict_enemy = [null, room1_dict_enemy, room2_dict_enemy]
#var player_room_start_point = [null, Vector2(0, 0), Vector2(3, 0)]
#var player_room_end_point = [null, Vector2(0, 0), Vector2(14, 0)]
var current_room = 2
var current_level = null

func get_neighbors_even_q(current: Vector2, grid: Dictionary) -> Array:
	var directions_even = [
		Vector2(1, 0),  # Right
		Vector2(-1, 0),  # Left
		Vector2(0, 1),  # Down
		Vector2(0, -1),  # Up
		Vector2(1, -1),  # Up-right
		Vector2(-1, -1)  # Up-left
	]
	
	var directions_odd = [
		Vector2(1, 0),  # Right
		Vector2(-1, 0),  # Left
		Vector2(0, 1),  # Down
		Vector2(0, -1),  # Up
		Vector2(1, 1),  # Down-right
		Vector2(-1, 1)  # Down-left
	]
	
	var neighbors = []
	var directions = directions_even if int(current.x) % 2 == 0 else directions_odd

	for dir in directions:
		var neighbor = current + dir
		# Check if the neighbor exists in the grid
		if grid.has(neighbor):
			neighbors.append(neighbor)
	return neighbors

func find_shortest_path_even_q(start: Vector2, target: Vector2, grid: Dictionary) -> Array:
	var queue = []
	var visited = {}
	var came_from = {}
	
	queue.append(start)
	visited[start] = true
	came_from[start] = null

	while queue.size() > 0:
		var current = queue.pop_front()
		
		if current == target:
			var path = []
			while current != null:
				path.append(current)
				current = came_from[current]
			path.reverse()
			return path
		
		for neighbor in get_neighbors_even_q(current, grid):
			if not visited.has(neighbor):
				queue.append(neighbor)
				visited[neighbor] = true
				came_from[neighbor] = current
				
	return []

#func find_straight_path_even_q(start: Vector2, direction: Vector2, grid: Dictionary) -> Array:
	#var path = [start]
	#var current = start
#
	#while true:
		#var next_pos = current + direction
#
		## Adjust for even-q vertical layout (odd/even column shift)
		#if direction in [Vector2(1, -1), Vector2(-1, -1)]:  # Up-right or Up-left
			#if int(current.x) % 2 == 0:
				#next_pos.y += 1  # Shift down for even columns
		#elif direction in [Vector2(1, 1), Vector2(-1, 1)]:  # Down-right or Down-left
			#if int(current.x) % 2 != 0:
				#next_pos.y -= 1  # Shift up for odd columns
#
		#if grid.has(next_pos):  # Valid tile check
			#path.append(next_pos)
			#current = next_pos
		#else:
			#break  # Stop if next tile is not valid
#
	#return path
