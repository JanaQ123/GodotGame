extends Area2D

@onready var timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		Engine.time_scale=0.7
		body.rotation = deg_to_rad(90)
		if self.is_in_group("water"):
			var water=get_node("WaterSplash");
			water.play()
		var deathSound=get_node("GameOver");
		if deathSound:
			deathSound.play()
		await get_tree().create_timer(0.8).timeout
		get_tree().reload_current_scene()
