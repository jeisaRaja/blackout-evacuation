extends Button

@onready var background_sprite := %Background as Sprite2D
@onready var item_sprite := %Item as Sprite2D


func _physics_process(delta):
	if is_hovered():
		# Darken the Control by adjusting its color (modulate)
		modulate = modulate.lerp(Color(0.8, 0.8, 0.8), 0.8)  # Darken by 50%
	else:
		modulate = Color(1, 1, 1)  # Reset to the original color (no modulation)


func update(item: InventoryItem):
	if not item:
		item_sprite.visible = false
	else:
		item_sprite.texture = item.texture
		item_sprite.visible = true
