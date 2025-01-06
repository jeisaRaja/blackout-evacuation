extends Control

@onready var inventory: Inventory = preload("res://scenes/player/player_inventory.tres")

@onready var hold_slot_scene = preload("res://gui/slot.tscn")
var hold_slot: Slot
var slots: Array


func _ready():
	initiate_slots()
	update()
	inventory.updated.connect(update)
	initiate_hold_slot()
	connect_slots()


func initiate_slots():
	var children = $NinePatchRect/GridContainer.get_children()
	for child in children:
		if child is Slot:
			slots.append(child)


func initiate_hold_slot():
	hold_slot = hold_slot_scene.instantiate()
	add_child(hold_slot)
	hold_slot.show_item_only()
	hold_slot.hide()
	hold_slot.mouse_filter = Control.MOUSE_FILTER_IGNORE


func connect_slots():
	var i := 0
	for slot in slots:
		if slot is Slot:
			slot.index = i
			slot.pressed.connect(_on_slot_pressed.bind(slot))
			i += 1


func update():
	for i in range(min(inventory.items.size(), slots.size())):
		if slots[i] is Slot:
			slots[i].insert(inventory.items[i])


func _on_slot_pressed(slot: Slot):
	if !hold_slot.item_resource:
		if slot.item_resource:
			hold_slot.insert(inventory.remove(slot.index))
			slot.take_item()
			hold_slot.follow_cursor()
	else:
		if slot.item_resource:
			var tmp_item = slot.take_item()
			slot.insert(hold_slot.take_item())
			inventory.insert_into(slot.index, slot.item_resource)
			hold_slot.insert(tmp_item)
			hold_slot.follow_cursor()
		else:
			inventory.insert_into(slot.index, hold_slot.take_item())
			hold_slot.hide_slot()
