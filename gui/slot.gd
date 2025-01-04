class_name Slot
extends Button

@onready var background_sprite := %Background as Sprite2D
@onready var item_sprite := %Item as Sprite2D
var item_resource: InventoryItem


func _physics_process(_delta):
	if is_hovered():
		modulate = modulate.lerp(Color(0.8, 0.8, 0.8), 0.8)
	else:
		modulate = Color(1, 1, 1)


func insert(item: InventoryItem):
	if not item:
		item_sprite.visible = false
	else:
		item_sprite.texture = item.texture
		item_sprite.visible = true
		item = item_resource


func take_item() -> InventoryItem:
	item_sprite = null
	item_sprite.visible = false
	var item = item_resource
	item_resource = null

	return item
