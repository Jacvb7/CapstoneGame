class_name pauseMenu
extends Control

@onready var resume: Button = $MarginContainer/HBoxContainer/VBoxContainer/resume
@onready var settings: Button = $MarginContainer/HBoxContainer/VBoxContainer/settings
@onready var quit: Button = $MarginContainer/HBoxContainer/VBoxContainer/quit
@onready var pause_menu: pauseMenu = $"."

#@onready var pause_menu: pauseMenu = $Pause_Menu
@onready var options_menu: OptionsMenu = $Options_Menu
@onready var margin_container: MarginContainer = $MarginContainer

@onready var start_level = preload("res://Scenes/mainmenu/main_menu.tscn") as PackedScene

#when creating the pause menu in order for the buttons to be displayed on the game state you need to go into the 
#inspector for this file, go to process and toggle the mode to "Always" in order for the buttons to be visible
#adding this to display pause menu over the game state 
func resume_game():
	margin_container.visible = false
	get_tree().paused = false
	
	
func pause_game():
	margin_container.visible = true
	get_tree().paused = true
	
#added an escape key binding to the game state in order to pause the game whenever
func escape_key():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause_game()
		
		

	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume_game()
		
		
func _process(delta):
	escape_key()
	

func _ready():
	resume.button_down.connect(_on_resume_pressed) # previous declaration
	settings.button_down.connect(_on_settings_button_down)
	quit.button_down.connect(_on_quit_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)

#func on_exit_pressed() -> void:
	#get_tree().quit()

#func _on_settings_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/user settings screen/settings.tscn")

func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false
	
#Reeha: Added this to change the visibility upon pressing settings button. Connection to settings menu
func _on_settings_button_down() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true
	
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_resume_pressed() -> void:
	resume_game()
	#pause_game().visible = false
	
	
func _on_quit_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/mainmenu/new_game_screen.tscn") 
	pass
