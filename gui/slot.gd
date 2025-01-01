extends Panel

@onready var background_sprite := %Background as Sprite2D
@onready var item_sprite := %Item as Sprite2D


func update(item: InventoryItem):
	if not item:
		item_sprite.visible = false
	else:
		item_sprite.texture = item.texture
		item_sprite.visible = true
