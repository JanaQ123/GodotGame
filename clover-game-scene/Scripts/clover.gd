extends AnimatableBody2D	

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		print("clover collected")
		queue_free()
