class_name ItemInteraction
extends Node2D

@export var input: BaseInput
@export var inventory: Inventory
@onready var detect_area: Area2D = $Area2D
var is_mouse_active := false
var is_mouse_hovering := false
enum HoverEnum { ITEM, READ }
var hover_type: HoverEnum

var hovered_objects: Array[Node2D] = []


func _ready():
	detect_area.area_entered.connect(_on_area_entered)
	detect_area.area_exited.connect(_on_area_exited)
	detect_area.mouse_entered.connect(_on_mouse_entered)
	detect_area.mouse_exited.connect(_on_mouse_exit)


func _physics_process(_delta):
	is_mouse_hovering = hovered_objects.size() != 0
	if !is_mouse_active or !is_mouse_hovering:
		Input.set_custom_mouse_cursor(Main.default_cursor, Input.CURSOR_ARROW, Vector2(16, 16))
		Input.set_custom_mouse_cursor(null)
		return

	if hover_type == HoverEnum.ITEM:
		Input.set_custom_mouse_cursor(Main.item_hover_cursor, Input.CURSOR_ARROW, Vector2(16, 16))
	if hover_type == HoverEnum.READ:
		Input.set_custom_mouse_cursor(Main.read_hover_cursor, Input.CURSOR_ARROW, Vector2(16, 16))

	if input.left_click:
		var selected_item = hovered_objects.pop_back()
		print(selected_item)
		if selected_item is Pickupable:
			selected_item.pickup(inventory)


func _on_area_entered(area: Area2D):
	if area is Pickupable:
		if not area.mouse_entered.is_connected(_on_mouse_entered_item):
			area.mouse_entered.connect(_on_mouse_entered_item.bind(area))
			area.mouse_exited.connect(_on_mouse_exited_item.bind(area))


func _on_area_exited(area: Area2D):
	if area is Pickupable:
		if area.mouse_entered.is_connected(_on_mouse_entered_item):
			area.mouse_entered.disconnect(_on_mouse_entered_item)
			area.mouse_exited.disconnect(_on_mouse_exited_item)


func _on_mouse_entered_item(area: Area2D):
	hovered_objects.append(area)
	hover_type = HoverEnum.ITEM


func _on_mouse_exited_item(area: Area2D):
	hovered_objects.erase(area)


func _on_mouse_entered():
	is_mouse_active = true


func _on_mouse_exit():
	is_mouse_active = false
