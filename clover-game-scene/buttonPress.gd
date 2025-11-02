extends AnimatableBody2D

var pressed;
func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		pressed=true;

func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("player")):
		pressed=false; # Replace with function body.

func _process(delta):
		if pressed==true:
			$buttonAnimation.play("pressed")
		if not pressed:
			$buttonAnimation.play("unpressed")
