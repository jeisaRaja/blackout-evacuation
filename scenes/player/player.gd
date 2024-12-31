class_name Player
extends Node2D

@onready var body_sprite = $Body as Sprite2D
@onready var legs_sprite = $Legs as Sprite2D


func _ready():
	pass


func _physics_process(_delta):
	body_sprite.look_at(get_global_mouse_position())
