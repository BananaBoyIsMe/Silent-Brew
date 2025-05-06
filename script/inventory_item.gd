extends Node2D

var drag_on = false
var in_slot = false
@export var item_id = 0

@onready var item_sprite = $SbPlant
@onready var item_area = $itm

func _ready() -> void:
	global.connect("inv_toggled", delete_inv)
	match item_id:
		1:
			item_sprite.texture = load("res://sprite/plant/sb_plant1.png")
			item_area.name = "item1"
		2:
			item_sprite.texture = load("res://sprite/plant/sb_plant2.png")
			item_area.name = "item2"
		3:
			item_sprite.texture = load("res://sprite/plant/sb_plant3.png")
			item_area.name = "item3"
		4:
			item_sprite.texture = load("res://sprite/plant/sb_plant4.png")
			item_area.name = "item4"
		5:
			item_sprite.texture = load("res://sprite/plant/sb_plant5.png")
			item_area.name = "item5"
		6:
			item_sprite.texture = load("res://sprite/plant/sb_plant6.png")
			item_area.name = "item6"
		7:
			item_sprite.texture = load("res://sprite/plant/sb_plant7.png")
			item_area.name = "item7"
		8:
			item_sprite.texture = load("res://sprite/plant/sb_plant8.png")
			item_area.name = "item8"
		9:
			item_sprite.texture = load("res://sprite/plant/sb_plant9.png")
			item_area.name = "item9"
		10:
			item_sprite.texture = load("res://sprite/plant/sb_plant10.png")
			item_area.name = "item10"
		11:
			item_sprite.texture = load("res://sprite/plant/sb_plant11.png")
			item_area.name = "item11"

func delete_inv(state: bool):
	if !state and !in_slot:
		self.queue_free()

func _physics_process(_delta: float) -> void:
	if !global.dragging_item:
		drag_on = false
	#print(in_slot)
	if drag_on:
		position = get_global_mouse_position()

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#print(event)
	var overlapping_areas = item_area.get_overlapping_areas()
	var size_down = false
	for i in overlapping_areas:
		if i.name.begins_with("item_slot"):
			size_down = true
	if size_down and scale.x > 0.55:
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	elif !size_down and scale.x < 0.55:
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2(1, 1), 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	if event.is_action_pressed("left_click"):
		if overlapping_areas.size() > 0 and drag_on and global.dragging_item:
			for area in overlapping_areas:
				if area.name.begins_with("item_slot"):
					#print("Hi")
					var num = area.name.right(-1).to_int()
					if global.inventory_list_id[num] == 0:
							global.inventory_list_id[num] = item_id
							global.inventory_list_obj[num] = self
							drag_on = false
							global.dragging_item = false
							in_slot = true
							position = area.global_position
							return
		if overlapping_areas.size() > 0 and global.dragging_item:
			var area = overlapping_areas
			for i in area:
				if i.name == "item_temp":
					drag_on = false
					global.dragging_item = drag_on
			return
		elif overlapping_areas.size() > 0 and !global.dragging_item:
			var area = overlapping_areas
			for i in area:
				if i.name == "item_temp":
					drag_on = true
					global.dragging_item = drag_on
				elif i.name.begins_with("item_slot"):
					var num = i.name.right(-1).to_int()
					global.inventory_list_id[num] = 0
					global.inventory_list_obj[num] = 0
					drag_on = !drag_on
					global.dragging_item = drag_on
					in_slot = false
			return

func _on_area_2d_mouse_entered() -> void:
	#print("Hi")
	if !in_slot:
		var tween2 = create_tween()
		tween2.tween_property(self, "scale", Vector2(1.2, 1.2), 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)


func _on_area_2d_mouse_exited() -> void:
	#print("bye")
	if !in_slot:
		var tween2 = create_tween()
		tween2.tween_property(self, "scale", Vector2(1, 1), 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
