class_name Inventory
extends Resource

signal updated
@export var items: Array[InventoryItem] = []
@export var item_on_hand: InventoryItem


func insert(item: InventoryItem):
	for i in range(items.size()):
		if not items[i]:
			items[i] = item
			break
	updated.emit()
