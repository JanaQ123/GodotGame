extends AnimatableBody2D




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		await get_tree().create_timer(0.5).timeout
		body.disable_control()
		body.reparent(self)
		$CloudAnimator.play("CloudCutsceneMoving")
		
