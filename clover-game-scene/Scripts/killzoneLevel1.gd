extends Area2D

@onready var timer: Timer = $Timer
var camera: Camera2D
@onready var game_over_sound: AudioStreamPlayer2D = $gameOverSound

func _on_body_entered(body: Node2D) -> void:
	Engine.time_scale = 0.05
	#await get_tree().create_timer(0.2).timeout
	camera=body.get_node("Camera2D")
	game_over_sound.play()
	body.rotation = deg_to_rad(90)
	camera.position.y+=100
	#body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
