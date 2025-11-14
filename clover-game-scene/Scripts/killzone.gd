extends Area2D

@onready var timer = $Timer
@onready var game_over_sound: AudioStreamPlayer2D = $"../gameOverSound"

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		game_over_sound.play()
		Engine.time_scale=0.5
		body.rotation = deg_to_rad(90)
		#body.get_node("CollisionShape2D").queue_free()
		timer.start()


func _on_timer_timeout():
	Engine.time_scale=1
	get_tree().reload_current_scene()
	
