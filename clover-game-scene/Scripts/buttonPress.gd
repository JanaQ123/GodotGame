extends AnimatableBody2D

@export var platform_path: NodePath
var platform: Node
var pressed = false
@onready var button_clicked: AudioStreamPlayer = $ButtonClicked

func _ready():
	if platform_path:
		platform = get_node(platform_path)
	else:
		push_error("⚠️ platform_path not set for button!")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pressed = true
		button_clicked.play()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		pressed = false

func _process(delta):
	if pressed:
		$buttonAnimation.play("pressed")
		if platform and platform.has_method("start_moving"):
			platform.start_moving()
	else:
		$buttonAnimation.play("unpressed")
		if platform and platform.has_method("return_to_start"):
			platform.return_to_start()
