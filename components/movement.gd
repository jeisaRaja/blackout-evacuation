class_name Movement
extends Node

@export var velocity: float
@export var input: BaseInput
@export var acceleration: float
@export var deceleration: float
@export var animation_player: AnimationPlayer

@onready var parent: CharacterBody2D = get_parent() as CharacterBody2D

var current_rotation: float
var direction_map = {
	Vector2(1, 0): 0,  # Right
	Vector2(-1, 0): PI,  # Left
	Vector2(0, 1): PI / 2,  # Down
	Vector2(0, -1): -PI / 2,  # Up
	Vector2(1, 1).normalized(): PI / 4,  # Bottom-right
	Vector2(-1, 1).normalized(): 3 * PI / 4,  # Bottom-left
	Vector2(1, -1).normalized(): -PI / 4,  # Top-right
	Vector2(-1, -1).normalized(): -3 * PI / 4  # Top-left
}


func _ready():
	if parent.legs_sprite:
		current_rotation = parent.legs_sprite.rotation


func _physics_process(delta):
	var target_velocity = input.direction * velocity
	var factor = acceleration if input.direction != Vector2.ZERO else deceleration
	parent.velocity = parent.velocity.lerp(target_velocity, factor * delta)
	parent.move_and_slide()

	if parent.legs_sprite:
		var leg_sprite_target_rotation = null
		for key in direction_map.keys():
			if input.direction == key:
				leg_sprite_target_rotation = direction_map[key]
				break

		if leg_sprite_target_rotation != null:
			current_rotation = lerp_angle(current_rotation, leg_sprite_target_rotation, 0.4)
			parent.legs_sprite.rotation = current_rotation

	if not animation_player:
		return

	if target_velocity != Vector2.ZERO:
		if animation_player.current_animation != "walk":
			animation_player.play("walk")
	else:
		if animation_player.current_animation != "RESET":
			animation_player.play("RESET")
