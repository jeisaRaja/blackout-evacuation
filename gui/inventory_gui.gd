extends Control

@onready var inventory: Inventory = preload("res://scenes/player/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

@onready var hold_slot_scene = preload("res://gui/slot.tscn")
var hold_slot: Slot


func _ready():
	update()
	inventory.updated.connect(update)
	initiate_hold_slot()
	connect_slots()


func initiate_hold_slot():
	hold_slot = hold_slot_scene.instantiate()
	add_child(hold_slot)
	hold_slot.show_item_only()
	hold_slot.hide()


func connect_slots():
	for slot in slots:
		if slot is Slot:
			slot.pressed.connect(_on_slot_pressed.bind(slot))


func update():
	for i in range(min(inventory.items.size(), slots.size())):
		print("adding item: ", inventory.items[i])
		slots[i].insert(inventory.items[i])


func _on_slot_pressed(slot: Slot):
	if !hold_slot.item_resource:
		if slot.item_resource:
			hold_slot.insert(slot.take_item())
			hold_slot.follow_cursor()
	else:
		if slot.item_resource:
			var tmp_item = slot.take_item()
			slot.insert(hold_slot.item_resource)
			hold_slot.insert(tmp_item)
			hold_slot.follow_cursor()
		else:
			slot.insert(hold_slot.take_item())
			hold_slot.insert(null)
			hold_slot.hide_slot()
