extends Area2D

@onready var ray_cast: RayCast2D = $RayCast2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if ray_cast.is_colliding() and body.get_collider().is_in_group("player"):
		print("player hit")
			
