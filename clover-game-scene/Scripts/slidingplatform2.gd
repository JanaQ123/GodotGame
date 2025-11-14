extends AnimatableBody2D

@export var move_distance: float = 112.0    # how far left/right from start
@export var move_speed: float = 60.0       # speed of oscillation
@export var return_speed: float = 60.0      # speed when returning to start

var start_x: float
var target_x: float
var moving_left := true
var oscillate := false   # true when Lucy is on the button
@onready var push_sound: AudioStreamPlayer2D = $PushSound

func _ready():
	start_x = position.x
	target_x = start_x
	set_process(true)
	

func start_moving():
	if not push_sound.playing:
		push_sound.play()
	oscillate = true
	target_x = start_x - move_distance
	moving_left = true

func return_to_start():
	
	oscillate = false
	target_x = start_x

func _process(delta):
	if oscillate:
		# move left or right continuously
		if moving_left:
			position.x = move_toward(position.x, start_x - move_distance, move_speed * delta)
			if position.x <= start_x - move_distance:
				moving_left = false
		else:
			position.x = move_toward(position.x, start_x, move_speed * delta)
			if position.x >= start_x:
				moving_left = true
	else:
		# return to start slowly
		position.x = move_toward(position.x, start_x, return_speed * delta)
