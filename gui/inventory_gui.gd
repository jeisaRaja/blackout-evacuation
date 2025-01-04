extends Control

@onready var inventory: Inventory = preload("res://scenes/player/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var item_on_hold: Slot


func _ready():
	update()
	inventory.updated.connect(update)
	item_on_hold = Slot.new()

	connect_slots()


func connect_slots():
	for slot in slots:
		slot.pressed.connect(_on_slot_pressed.bind(slot))


func update():
	for i in range(min(inventory.items.size(), slots.size())):
		print("adding item: ", inventory.items[i])
		slots[i].update(inventory.items[i])


func _on_slot_pressed(slot: Slot):
	if !item_on_hold:
		if slot.item_resource:
			item_on_hold.insert(slot.take_item())
	else:
		if slot.item_resource:
			var tmp_item = slot.take_item()
			slot.insert(item_on_hold.item_resource)
			item_on_hold.insert(tmp_item)
		else:
			item_on_hold.insert(null)
