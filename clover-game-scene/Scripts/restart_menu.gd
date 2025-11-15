extends Control

@onready var restartMenu: Control = $"."
var menu_open=false
var previousTime
func _ready():
	restartMenu.hide()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func esc_press():
	if Input.is_action_just_pressed("escape"):
		menu_open = !menu_open
		restartMenu.visible = menu_open
		if menu_open:
			get_tree().paused = true

		else:
			get_tree().paused = false

		

func _on_resume_pressed() -> void:
	get_tree().paused = false
	restartMenu.hide()
	
func _process(delta):
	esc_press()
