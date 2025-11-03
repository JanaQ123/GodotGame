extends Sprite2D

@export var player: CharacterBody2D 
	
func _ready() -> void:
	player.visible = false
	player.disable_control()
	await get_tree().create_timer(2).timeout
	player.visible = true
	player.can_move = true
