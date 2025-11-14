extends Node
var confetti1
var confetti2
@onready var win_sound: AudioStreamPlayer2D = $"../Confetti/WinSound"
@onready var level_3_bg_music: AudioStreamPlayer2D = $Level3BgMusic
var alreadyWon=false
@export var camera: Camera2D

func _ready():
	confetti1=get_node("Confetti1")
	confetti2=get_node("Confetti2")
	confetti1.visible = false
	confetti2.visible = false
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if  body.is_in_group("player") and not alreadyWon:
		confetti1.visible = true
		confetti2.visible = true
		win_sound.play()
		level_3_bg_music.volume_db=-10
		alreadyWon=true;
		camera.position.y=-3000
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		level_3_bg_music.volume_db=5
		camera.position.y=14
