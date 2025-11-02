extends AnimatableBody2D

@export var wobble_speed: float = 10.0
@export var wobble_height: float = 2.0
@export var fall_speed: float = 250.0
@export var collapse_delay: float = 0.5
@export var destroy_delay: float = 1.0

var time := 0.0
var collapsing := false

func _ready():
	set_process(false)

	# Connect signals once
	if not $Area2D.body_entered.is_connected(_on_area_2d_body_entered):
		$Area2D.body_entered.connect(_on_area_2d_body_entered)
	if not $Timer.timeout.is_connected(_on_timer_timeout):
		$Timer.timeout.connect(_on_timer_timeout)

func _process(delta):
	if not collapsing:
		time += delta * wobble_speed
		$Sprite2D.position.y = sin(time) * wobble_height
	else:
		position.y += fall_speed * delta

func _on_area_2d_body_entered(body):
	print("Body entered: ", body.name)
	if body.name == "lucy":
		print("Lucy triggered collapse!")
		set_process(true)
		$Timer.start(collapse_delay)


func _on_timer_timeout():
	if not collapsing:
		collapsing = true 
		$CPUParticles2D.local_coords = true
		$CPUParticles2D.emitting = true
		# remove collision so Lucy falls through
		if $CollisionShape2D:
			$CollisionShape2D.disabled = true
		if $Area2D:
			$Area2D.queue_free()
		$Timer.start(destroy_delay)
	else:
		queue_free()
