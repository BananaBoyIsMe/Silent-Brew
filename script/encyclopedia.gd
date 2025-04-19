extends Node2D

var all_plants_info = [null, 
preload("res://scene/encyclopedia/heally_pad_1.tscn"),
preload("res://scene/encyclopedia/snow_berry_2.tscn"),
preload("res://scene/encyclopedia/crystal_fruit_3.tscn"),
preload("res://scene/encyclopedia/laetiporus_4.tscn"),
preload("res://scene/encyclopedia/death_cap_5.tscn"),
preload("res://scene/encyclopedia/black_salmon_berry_6.tscn"),
preload("res://scene/encyclopedia/murder_maple_7.tscn"),
preload("res://scene/encyclopedia/sound_bloom_8.tscn"),
preload("res://scene/encyclopedia/coughing_bean_9.tscn"),
preload("res://scene/encyclopedia/soap_basil_10.tscn"),
preload("res://scene/encyclopedia/sun_flower_11.tscn"),
]
var cur_info
var stop = false

@onready var book_pos = $encyclopedia
@onready var pages = $pages
@onready var info_place = $info

func _change_info(num: int) -> void:
	var plant_info = info_place.get_child(0)
	if plant_info:
		plant_info.queue_free()
	
	#print(global.cur_book_page)
	cur_info = all_plants_info[num].instantiate()
	cur_info.name = "cur_plant_info"
	cur_info.position = book_pos.position
	cur_info.z_index = 10
	info_place.add_child(cur_info)
	pages.text = "Page " + str(num) + "/" + str(all_plants_info.size() - 1)
	
	cur_info = null

func _ready() -> void:
	_change_info(global.cur_book_page)

func _on_left_bt_button_up() -> void:
	if global.cur_book_page > 1:
		pass
	else:
		return
	if stop:
		return
	stop = true
	global.book_on = !global.book_on
	#print("Hi_left")
	
	#await get_tree().create_timer(0.1).timeout
	if global.cur_book_page > 1:
		global.cur_book_page -= 1
		_change_info(global.cur_book_page)
	else:
		return
	
	global.book_on = !global.book_on
	stop = false

func _on_right_bt_button_up() -> void:
	if global.cur_book_page < (all_plants_info.size() - 1):
		pass
	else:
		return
	if stop:
		return
	stop = true
	global.book_on = !global.book_on
	#print("Hi_right")
	
	#await get_tree().create_timer(0.1).timeout
	if global.cur_book_page < (all_plants_info.size() - 1):
		global.cur_book_page += 1
		_change_info(global.cur_book_page)
	else:
		return
	
	global.book_on = !global.book_on
	stop = false
