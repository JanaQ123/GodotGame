extends Area2D

@onready var timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		Engine.time_scale=0.7
		body.get_node("CollisionShape2D").queue_free()
		timer.start()


func _on_timer_timeout():
	Engine.time_scale=1
	get_tree().reload_current_scene()
	
