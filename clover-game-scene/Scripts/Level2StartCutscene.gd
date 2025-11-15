extends AnimatableBody2D




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		await get_tree().create_timer(1).timeout
		body.disable_control()
		body.reparent(self)
		$CloudAnimator.play("CloudCutsceneMoving")
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://scenes/level3.tscn")
		
