extends Node2D
@onready var drag_to_eat_label = $Label
@onready var item_slot1 = $SbInventory/item_slot1
@onready var item_slot2 = $SbInventory/item_slot2
@onready var item_slot3 = $SbInventory/item_slot3
@onready var item_slot4 = $SbInventory/item_slot4
@onready var item_slot5 = $SbInventory/item_slot5
@onready var item_slot6 = $SbInventory/item_slot6

func _ready() -> void:
	global.connect("add_inventory", new_item)
	loop()

func loop() -> void:
	var tween = create_tween()
	tween.tween_property(drag_to_eat_label, "scale", Vector2(1.2, 1.2), 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await get_tree().create_timer(2).timeout
	var tween1 = create_tween()
	tween1.tween_property(drag_to_eat_label, "scale", Vector2(1, 1), 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await get_tree().create_timer(2).timeout
	loop()

func new_item(item: String):
	var regex := RegEx.new()
	regex.compile("\\d")
	var no_numbers = regex.sub(item, "", true)
	#print(no_numbers)
	match no_numbers:
		"black_berry":
			var itemm = load("res://scene/inventory/inventory_item.tscn").instantiate()
			itemm.item_id = 6
			itemm.position = Vector2(543.0, 600.0)
			add_child(itemm)
		"snow":
			var itemm = load("res://scene/inventory/inventory_item.tscn").instantiate()
			itemm.item_id = 2
			itemm.position = Vector2(450.0, 500.0)
			add_child(itemm)
		"water_cry":
			var itemm = load("res://scene/inventory/inventory_item.tscn").instantiate()
			itemm.item_id = 3
			itemm.position = Vector2(450.0, 500.0)
			add_child(itemm)


func _on_eat_here_area_entered(area: Area2D) -> void:
	audio.play_eat()
	var item = area.get_parent()
	match item.item_id:
		2:
			global.player_cur_health -= 5
		3:
			global.player_cur_health += 5
		6:
			global.player_cur_health += 10
			#print("Hisoi")
	item.queue_free()
