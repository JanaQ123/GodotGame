extends StaticBody2D

@onready var timer: Timer = $Area2D/Timer
@onready var player: AnimatedSprite2D = $AnimatedSprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	
func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	print("scene restarted")
	get_tree().reload_current_scene()
