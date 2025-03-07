#class_name pauseMenu
extends Control


@onready var resume: Button = $MarginContainer/HBoxContainer/VBoxContainer/resume
@onready var settings: Button = $MarginContainer/HBoxContainer/VBoxContainer/settings
@onready var quit: Button = $MarginContainer/HBoxContainer/VBoxContainer/quit


@onready var options_menu: OptionsMenu = $Options_Menu
@onready var margin_container: MarginContainer = $MarginContainer
#test branch 

@onready var start_level = preload("res://Scenes/mainmenu/main_menu.tscn") as PackedScene

func _ready():
	resume.button_down.connect(_on_resume_pressed)
	settings.button_down.connect(_on_settings_pressed)
	quit.button_down.connect(_on_quit_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)


func resume_game() -> void:
	get_tree().paused = false
	
func pause_game() -> void:
	get_tree().paused = true
	
func esc_key_pressed() -> void:
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause_game()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume_game()


func _on_resume_pressed() -> void:
	resume_game()

func _on_settings_pressed() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()


func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false
	
#func _on_resume_button_down() -> void:
	#get_tree().change_scene_to_file("res://Scenes/Debug Scenes/test_player_house_tilemap.tscn")
	
#func _on_quit_button_down() -> void:
	#get_tree().change_scene_to_file("res://Scenes/mainmenu/main_menu.tscn")
	#
#Reeha: Added this to change the visibility upon pressing settings button. Connection to settings menu
#func _on_settings_button_down() -> void:
	#margin_container.visible = false
	#options_menu.set_process(true)
	#options_menu.visible = true
	
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	esc_key_pressed()

#func on_exit_pressed() -> void:
	#get_tree().quit()
