extends Area2D

@export var damage: int = 10

func _ready() -> void:
	# Connect signal for detecting bodies
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
		else:
			print("Player touched hazard! But no take_damage() found.")
