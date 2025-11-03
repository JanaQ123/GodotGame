extends StaticBody2D


# Called when the node enters the scene tree for the first time.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/CloudLevel3.tscn")
 
