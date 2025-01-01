class_name ItemInteraction
extends Node2D

@onready var detect_area: Area2D = $Area2D


func _ready():
	detect_area.area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D):
	if area is Toggleable:
		print("something is toggleable")
