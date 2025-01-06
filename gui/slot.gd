class_name Slot
extends Button

@onready var background_sprite := %Background as Sprite2D
@onready var item_sprite := %Item as Sprite2D
var item_resource: InventoryItem
var is_follow_cursor := false
var index: int


func _process(_delta):
	if is_hovered():
		modulate = Color(0.8, 0.8, 0.8)
	else:
		modulate = Color(1, 1, 1)


func _physics_process(_delta):
	if is_follow_cursor:
		global_position = get_global_mouse_position() + Vector2(-8, -16)


func insert(item: InventoryItem):
	if not item:
		item_sprite.visible = false
	else:
		item_sprite.texture = item.texture
		item_sprite.visible = true
		item_resource = item


func take_item() -> InventoryItem:
	item_sprite.texture = null
	item_sprite.visible = false
	var item = item_resource
	item_resource = null

	return item


func show_item_only():
	background_sprite.visible = false


func follow_cursor():
	show()
	is_follow_cursor = true


func hide_slot():
	is_follow_cursor = false
	hide()
