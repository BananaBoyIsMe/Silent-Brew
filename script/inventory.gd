extends Node2D

@onready var item_slot1 = $SbInventory/item_slot1
@onready var item_slot2 = $SbInventory/item_slot2
@onready var item_slot3 = $SbInventory/item_slot3
@onready var item_slot4 = $SbInventory/item_slot4
@onready var item_slot5 = $SbInventory/item_slot5
@onready var item_slot6 = $SbInventory/item_slot6

func _ready() -> void:
	global.connect("add_inventory", new_item)

func new_item(item: String):
	match item:
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

func _physics_process(_delta: float) -> void:
	pass
