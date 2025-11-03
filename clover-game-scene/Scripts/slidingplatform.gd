extends AnimatableBody2D

@export var move_distance: float = 200.0
@export var move_speed: float = 100.0
@export var return_speed: float = 50.0

var start_x: float
var target_x: float
var moving_right := false

func _ready():
	start_x = position.x
	target_x = start_x
	set_process(true)

func start_moving():
	moving_right = true
	target_x = start_x + move_distance

func return_to_start():
	moving_right = false
	target_x = start_x

func _process(delta):
	if moving_right:
		position.x = move_toward(position.x, target_x, move_speed * delta)
	else:
		position.x = move_toward(position.x, target_x, return_speed * delta)
