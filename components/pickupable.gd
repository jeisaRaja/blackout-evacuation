class_name Pickupable
extends Area2D

@export var item_resource: InventoryItem
var carried_by: Node2D
var stored_in: Node2D
var is_on_hand := false
var is_mouse_hovering := false


func _ready():
	pass


func _mouse_enter():
	is_mouse_hovering = true


func _mouse_exit():
	is_mouse_hovering = false


func pickup(inventory: Inventory):
	inventory.insert(self)
