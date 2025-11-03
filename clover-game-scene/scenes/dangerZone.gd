extends Area2D

@onready var timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		print("i am mushrom u entered me")
		Engine.time_scale=0.7
		await get_tree().create_timer(0.5).timeout
		body.get_node("CollisionShape2D").queue_free()
		await get_tree().create_timer(1.5).timeout
		get_tree().reload_current_scene()
