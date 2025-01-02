class_name PlayerInput
extends BaseInput


func _ready():
	pass


func _physics_process(_delta):
	direction = Input.get_vector("left", "right", "up", "down")
	left_click = Input.is_action_just_pressed("left_click")
	right_click = Input.is_action_just_pressed("right_click")

