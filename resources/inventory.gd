class_name Inventory
extends Resource

signal updated
@export var items: Array[InventoryItem] = []
@export var item_on_hand: InventoryItem


func insert(item: Pickupable):
	for i in range(items.size()):
		if not items[i]:
			items[i] = item.item_resource
			updated.emit()
			item.get_parent().queue_free()
			break


func remove(index: int) -> InventoryItem:
	if index >= 0 and index < items.size():
		var item = items[index]
		items[index] = null
		updated.emit()
		return item
	return null


func insert_into(index, item: InventoryItem):
	print(index, item)
	items[index] = item
	updated.emit()
