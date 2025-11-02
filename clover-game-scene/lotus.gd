extends AnimatableBody2D

@export var move_distance: float = 100.0
@export var move_speed: float = 100.0

var moving = false
var direction = 1
var start_position: Vector2

func _ready():
	start_position = position
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):  # make sure your player is in "player" group
		moving = true

func _process(delta):
	if not moving:
		return
	
	position.x += direction * move_speed * delta
	
	if position.x > start_position.x + move_distance:
		direction = -1
	elif position.x < start_position.x - move_distance:
		direction = 1
