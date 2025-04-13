class_name MainMenu
extends Control

@onready var start_game: Button = $MarginContainer/HBoxContainer/VBoxContainer/start_game
#@onready var load_game: Button = $MarginContainer/HBoxContainer/VBoxContainer/load_game
@onready var settings: Button = $MarginContainer/HBoxContainer/VBoxContainer/settings
@onready var exit_game: Button = $MarginContainer/HBoxContainer/VBoxContainer/exit_game
#Reeha: Added these two variables below
@onready var options_menu: OptionsMenu = $Options_Menu
@onready var margin_container: MarginContainer = $MarginContainer

@onready var start_level = preload("res://Scenes/mainmenu/main_menu.tscn") as PackedScene



func _ready():
	start_game.button_down.connect(_on_start_game_button_down)
	settings.button_down.connect(_on_settings_button_down)
	#load_game.button_down.connect(_on_load_game_button_down)
	options_menu.exit_options_menu.connect(on_exit_options_menu)

#Reeha: Commented out. Can possibly delete this
#func on_start_pressed() -> void:
	#get_tree().change_scene_to_packed(start_level)
	
func on_exit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:	
	get_tree().change_scene_to_file("res://Scenes/user settings screen/settings.tscn")


#func _on_start_game_button_down() -> void:
#	get_tree().change_scene_to_file("res://Scenes/test/test_player_house_tilemap.tscn")
#Reeha: Commented out. Can possibly delete this
#func on_exit_pressed() -> void:
	#get_tree().quit()
	
#Reeha: Added this for the exit button. (Going from options screen back to main menu
func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false
	
func _on_start_game_button_down() -> void:
	get_tree().change_scene_to_file("res://Levels/Level 1/Level 1.tscn")
	
	
	
	
#Reeha: Added this to change the visibility upon pressing settings button. Connection to settings menu
func _on_settings_button_down() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true
	
#Jacob: Added this to be able to quit out of the game from the main menu and eventually pause menu
func _on_exit_game_button_down() -> void: 
	get_tree().quit()

#func _on_load_game_button_down() -> void:
#	get_tree().change_scene_to_file("res://Scenes/load_game_screen/load_game.tscn")


		
