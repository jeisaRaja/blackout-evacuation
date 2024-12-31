class_name PlayerInput
extends BaseInput


func _ready():
	pass


func _physics_process(_delta):
	direction = Input.get_vector("left", "right", "up", "down")
