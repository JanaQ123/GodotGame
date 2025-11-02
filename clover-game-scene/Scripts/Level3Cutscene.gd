extends AnimatableBody2D

var sprite1;
var sprite2;
var sprite3;

@export var background_node: Sprite2D

func _ready():
	sprite1 = get_node("Cloud1")
	sprite2=get_node("Cloud2")
	
func _on_area_2d_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			await get_tree().create_timer(0.5).timeout
			body.disable_control()
			await get_tree().create_timer(1.5).timeout
			sprite1.texture = preload("res://cloudy skies/19Grey.png")
			sprite2.texture = preload("res://cloudy skies/19Grey.png")
			background_node.texture=preload("res://cloudy skies/newgreybackground.png")
			await get_tree().create_timer(2).timeout
			body.free_fall()
			for shape in get_children():
				if shape is CollisionShape2D:
					shape.disabled = true
			
