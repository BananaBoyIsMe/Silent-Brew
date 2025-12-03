extends Node2D

var select_level_list = []
var select_level_cur = []
var current_level = 1
var not_done = false
var gone = true

@onready var level_num = $level_num
@onready var play_bt = $play
@onready var back_bt = $back

func _ready() -> void:
	select_level_list.append($sb_select_level0)
	select_level_list.append($sb_select_level1)
	select_level_list.append($sb_select_level2)
	select_level_list.append($sb_select_level3)
	select_level_list.append($sb_select_level4)
	select_level_list.append($sb_select_level5)
	select_level_list.append($sb_select_level6)
	select_level_list.append($sb_select_level7)
	select_level_list.append($sb_select_level8)
	select_level_list.append($sb_select_level9)
	select_level_list.append($sb_select_level10)
	select_level_list.append($sb_select_level11)
	select_level_list.append($sb_select_level12)
	select_level_list.append($sb_select_level13)
	select_level_list.append($sb_select_level14)
	select_level_list.append($sb_select_level15)
	#select_level_list.append($sb_select_level16)
	#select_level_list.append($sb_select_level17)
	#select_level_list.append($sb_select_level18)
	#select_level_list.append($sb_select_level19)
	#select_level_list.append($sb_select_level20)
	#select_level_list.append($sb_select_level21)
	
	select_level_cur.append(select_level_list[15])
	select_level_cur.append(select_level_list[0])
	select_level_cur.append(select_level_list[1])
	select_level_cur.append(select_level_list[2])
	select_level_cur.append(select_level_list[3])
	
	var num = 0
	for i in global.completed_level:
		if i == -1:
			select_level_list[num].get_child(1).visible = true
		num += 1
	
	await get_tree().create_timer(1).timeout
	gone = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta: float) -> void:
	#select_level_cur[1].position.x = move_toward(select_level_cur[1].position.x, 420, 1 * delta * (420 - select_level_cur[1].position.x))
	#select_level_cur[2].position.x = move_toward(select_level_cur[2].position.x, 960, 1 * delta * (960 - select_level_cur[2].position.x))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and !gone:
		gone = true
		get_parent().get_node("paused").back_to_menu_select()
		back_bt.disabled = true
	elif event.is_action_pressed("ui_left") and !gone:
		_on_left_bt_button_up()
	elif event.is_action_pressed("ui_right") and !gone:
		_on_right_bt_button_up()

func _on_left_bt_button_up() -> void:
	audio.play_button()
	if not_done or gone:
		return
	
	not_done = true
	
	current_level -= 1
	if current_level < 0:
		current_level = 15
	
	level_num.text = "Level " + str(current_level) + ": "
	match current_level:
		0:
			level_num.text += "Tutorial"
			play_bt.disabled = false
		1:
			level_num.text += "Calm camp"
			play_bt.disabled = false
		2:
			level_num.text += "The bees"
			play_bt.disabled = false
		3:
			level_num.text += "The beach"
			play_bt.disabled = false
		4:
			level_num.text += "Slippery crystal cave"
			play_bt.disabled = false
		5:
			level_num.text += "Lava cave"
			play_bt.disabled = false
		6:
			level_num.text += "Granny hut"
			play_bt.disabled = false
		7:
			level_num.text += "Inside Granny hut"
			play_bt.disabled = false
		8:
			level_num.text += "Murder Maple"
			play_bt.disabled = false
		9:
			level_num.text += "The lake"
			play_bt.disabled = false
		10:
			level_num.text += "The empty town?"
			play_bt.disabled = false
		11:
			level_num.text += "Uncle Nord"
			play_bt.disabled = false
		12:
			level_num.text += "The camp again"
			play_bt.disabled = false
		13:
			level_num.text += "The chaotic beach"
			play_bt.disabled = false
		14:
			level_num.text += "I'm... tired"
			play_bt.disabled = false
		15:
			level_num.text += "Mountain heart"
			play_bt.disabled = false
	level_num.text = level_num.text
	
	var add_level = current_level - 2
	if add_level == -2:
		add_level = 14
	if add_level == -1:
		add_level = 15
	#var temp = select_level_cur.pop_back()
	select_level_cur.pop_back()
	select_level_cur.insert(0, select_level_list[add_level])
	select_level_cur[0].position.x = -120
	
	var num = 0
	for i in select_level_cur:
		var tween = create_tween()
		tween.tween_property(i, "position:x", -120 + (num * 540), 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		num += 1
	
	var tween1 = create_tween()
	tween1.tween_property(select_level_cur[3], "scale", Vector2(0.07, 0.07) , 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween2 = create_tween()
	tween2.tween_property(select_level_cur[2], "scale", Vector2(0.15, 0.15), 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	
	var tween00 = create_tween()
	tween00.tween_property(select_level_cur[4], "modulate:a", 0, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween11 = create_tween()
	tween11.tween_property(select_level_cur[3], "modulate:a", 0.5, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween22 = create_tween()
	tween22.tween_property(select_level_cur[2], "modulate:a", 1, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween33 = create_tween()
	tween33.tween_property(select_level_cur[1], "modulate:a", 0.5, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	
	await get_tree().create_timer(0.2).timeout
	
	not_done = false

func _on_right_bt_button_up() -> void:
	audio.play_button()
	if not_done or gone:
		return
	
	not_done = true
	
	current_level += 1
	if current_level > 15:
		current_level = 0
	#print(current_level, " :cur_level")
	level_num.text = "Level " + str(current_level) + ": "
	match current_level:
		0:
			level_num.text += "Tutorial"
			play_bt.disabled = false
		1:
			level_num.text += "Calm camp"
			play_bt.disabled = false
		2:
			level_num.text += "The bees"
			play_bt.disabled = false
		3:
			level_num.text += "The beach"
			play_bt.disabled = false
		4:
			level_num.text += "Slippery crystal cave"
			play_bt.disabled = false
		5:
			level_num.text += "Lava cave"
			play_bt.disabled = false
		6:
			level_num.text += "Granny hut"
			play_bt.disabled = false
		7:
			level_num.text += "Inside Granny hut"
			play_bt.disabled = false
		8:
			level_num.text += "Murder maple"
			play_bt.disabled = false
		9:
			level_num.text += "The lake"
			play_bt.disabled = false
		10:
			level_num.text += "The empty town?"
			play_bt.disabled = false
		11:
			level_num.text += "Uncle Nord"
			play_bt.disabled = false
		12:
			level_num.text += "The camp again"
			play_bt.disabled = false
		13:
			level_num.text += "The chaotic beach"
			play_bt.disabled = false
		14:
			level_num.text += "I'm... tired"
			play_bt.disabled = false
		15:
			level_num.text += "Mountain heart"
			play_bt.disabled = false
	level_num.text = level_num.text
	
	var add_level = current_level + 2
	if add_level == 17:
		add_level = 1
	if add_level == 16:
		add_level = 0
	#var temp = select_level_cur.pop_back()
	select_level_cur.pop_front()
	select_level_cur.append(select_level_list[add_level])
	select_level_cur[4].position.x = 2040
	
	var num = 0
	for i in select_level_cur:
		var tween = create_tween()
		tween.tween_property(i, "position:x", -120 + (num * 540), 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		num += 1
	
	var tween1 = create_tween()
	tween1.tween_property(select_level_cur[1], "scale", Vector2(0.07, 0.07) , 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween2 = create_tween()
	tween2.tween_property(select_level_cur[2], "scale", Vector2(0.15, 0.15), 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	
	var tween00 = create_tween()
	tween00.tween_property(select_level_cur[0], "modulate:a", 0, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween11 = create_tween()
	tween11.tween_property(select_level_cur[3], "modulate:a", 0.5, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween22 = create_tween()
	tween22.tween_property(select_level_cur[2], "modulate:a", 1, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween33 = create_tween()
	tween33.tween_property(select_level_cur[1], "modulate:a", 0.5, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	
	await get_tree().create_timer(0.2).timeout
	
	not_done = false

func _on_play_button_up() -> void:
	audio.play_button()
	if gone:
		return
	gone = true
	play_bt.disabled = true
	global.current_room = current_level
	get_parent().get_node("paused").deactivate_menu()
	#get_parent().start_room()
	var tween1 = create_tween()
	tween1.tween_property(self, "position:y", 2500, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	await get_tree().create_timer(1).timeout
	self.queue_free()

func _on_back_button_up() -> void:
	audio.play_button()
	if gone:
		return
	gone = true
	get_parent().get_node("paused").back_to_menu_select()
	back_bt.disabled = true
