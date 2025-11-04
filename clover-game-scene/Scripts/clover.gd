extends AnimatableBody2D

#func _on_body_entered(body: Node2D) -> void:
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.power_up()
		queue_free()
 
