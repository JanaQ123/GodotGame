extends AnimatableBody2D

var can_push := true

func _ready() -> void:
	# Connect the signal in code to avoid editor connection issues
	#$Area2D.body_entered.connect(_on_area_2d_body_entered)
	print("Enemy ready and listening for collisions")

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Something entered me:", body.name)
	if not can_push:
		return
	if body.has_method("take_knockback"):
		can_push = false
		var push_dir = (body.global_position - global_position).normalized()
		body.take_knockback(push_dir, 600.0)  
		await get_tree().create_timer(0.3).timeout
		can_push = true
