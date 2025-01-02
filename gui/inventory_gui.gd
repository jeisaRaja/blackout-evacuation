extends Control

@onready var inventory: Inventory = preload("res://scenes/player/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()


func _ready():
	update()
	inventory.updated.connect(update)


func update():
	for i in range(min(inventory.items.size(), slots.size())):
		print("adding item: ", inventory.items[i])
		slots[i].update(inventory.items[i])
