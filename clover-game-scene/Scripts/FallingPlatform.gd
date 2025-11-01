extends StaticBody2D
var original_position: Vector2
var is_falling := false
var fall_speed := 0.0

func _ready() -> void:
	$Area2D.body_entered.connect(_on_area_2d_body_entered)
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		await get_tree().create_timer(0.3).timeout
		is_falling = true
		original_position = global_position


func _physics_process(delta):
	if is_falling:
		fall_speed += 800 * delta  # gravity
		global_position.y += fall_speed * delta
		if global_position.y > 1000:
			reset_platform()

func reset_platform():
	global_position = original_position
	fall_speed = 0.0
	is_falling = false
