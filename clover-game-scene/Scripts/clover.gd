extends AnimatableBody2D

#func _on_body_entered(body: Node2D) -> void:
	
func _ready() -> void:
	print("hiii I work!!")

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		print("clover collected")
		body.power_up()
		queue_free()
