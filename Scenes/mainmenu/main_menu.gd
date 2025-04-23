# This script handles logic for the Main Menu screen.
class_name MainMenu
extends Control

# Button references from the scene
@onready var start_game: Button = $MarginContainer/HBoxContainer/VBoxContainer/start_game
@onready var settings: Button = $MarginContainer/HBoxContainer/VBoxContainer/settings
@onready var exit_game: Button = $MarginContainer/HBoxContainer/VBoxContainer/exit_game

# Reference to the options/settings menu scene and container
@onready var options_menu: OptionsMenu = $Options_Menu
@onready var margin_container: MarginContainer = $MarginContainer
@onready var help_button: Button = $MarginContainer/VBoxContainer2/HelpButton


# Called when the node enters the scene tree
func _ready():
	# Connect button presses to their respective functions
	start_game.button_down.connect(_on_start_game_button_down)
	settings.button_down.connect(_on_settings_button_down)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
	help_button.button_down.connect(_on_help_button_button_down)


# Loads Level 1 when the Start Game button is pressed
func _on_start_game_button_down() -> void:
	get_tree().change_scene_to_file("res://Levels/Level 1/Level 1.tscn")

	
#Shows the options menu and hides main menu content
func _on_settings_button_down() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true


#Handles returning from the options/settings menu back to the main menu
func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false


#Allows the game to be exited from the main menu
func _on_exit_game_button_down() -> void: 
	get_tree().quit()


func _on_help_button_button_down() -> void:
	OS.shell_open("https://docs.google.com/document/d/1JglxoCD9LgmA5xCS-_VFxYuatIop8Nm1U663883mTa4/edit?usp=sharing")
