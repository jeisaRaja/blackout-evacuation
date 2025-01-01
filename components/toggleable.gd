class_name Toggleable
extends Pickupable

signal turned_on
signal turned_off
var is_on := false


func _ready():
	pass


func toggle():
	if is_on:
		turn_off()
		is_on = false
	else:
		turn_on()
		is_on = true


func turn_on():
	turned_on.emit()


func turn_off():
	turned_off.emit()
