

extends Node2D

@export var rotation_speed: float = 120.0  # degrees per second

func _process(delta):
	rotation_degrees += rotation_speed * delta
