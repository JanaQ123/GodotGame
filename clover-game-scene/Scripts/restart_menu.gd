extends Control

@onready var restartMenu: Control = $"."

func _ready():
	restartMenu.hide()

#func resume():
	#get_tree().paused = false
	#restartMenu.hide()
	
#func pause():
	#get_tree().paused = true
	#restartMenu.show()

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func esc_press():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		restartMenu.show()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		restartMenu.hide()

func _on_resume_pressed() -> void:
	restartMenu.hide()
