extends AnimatableBody2D

#func _on_body_entered(body: Node2D) -> void:
	


func _on_area_2d_body_entered(body):
	print("clover collected")
	queue_free()
