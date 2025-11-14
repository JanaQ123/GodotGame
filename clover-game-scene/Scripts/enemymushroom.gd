extends Node2D
const SPEED=50

var left=true;
@onready var game_over_sound: AudioStreamPlayer2D = $gameOverSound
var resolved = false

func _ready():
	$mushi.play("default")


func _process(_delta: float) -> void:
	if left:
		position.x+= -SPEED * _delta
		await get_tree().create_timer(2).timeout
		left=false;
	else:
		$mushi.flip_h=true;
		position.x-= -SPEED * _delta
		await get_tree().create_timer(2).timeout
		left=true;
		$mushi.flip_h=false ;


func _on_kill_player_body_entered(body: Node2D) -> void:
	if resolved: return
	if body.is_in_group("player"):
		resolved=true
		$killMushroom/ikilluzone.disabled=true
		game_over_sound.play()
		body.rotation = deg_to_rad(90)
		await get_tree().create_timer(1).timeout
		get_tree().reload_current_scene()





func _on_kill_mushroom_body_entered(body: Node2D) -> void:
	if resolved: return
	if body.is_in_group("player"):
		resolved=true
		$killPlayer/ukillmezone.disabled=true
		$mushi.play("death")
		queue_free()
