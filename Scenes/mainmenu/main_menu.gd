class_name MainMenu
extends Control

@onready var start_game: Button = $MarginContainer/HBoxContainer/VBoxContainer/start_game
@onready var exit_game: Button = $MarginContainer/HBoxContainer/VBoxContainer/exit_game
@onready var settings: Button = $MarginContainer/HBoxContainer/VBoxContainer/settings
#Reeha: Added these two variables below
@onready var options_menu: OptionsMenu = $Options_Menu
@onready var margin_container: MarginContainer = $MarginContainer


@onready var start_level = preload("res://Scenes/mainmenu/main_menu.tscn") as PackedScene

func _ready():
	#Reeha: modified the function names a little
	start_game.button_down.connect(_on_start_game_button_down)
	settings.button_down.connect(_on_settings_button_down)
	exit_game.button_down.connect(_on_exit_game_button_down)
	options_menu.exit_options_menu.connect(on_exit_options_menu)

#Reeha: Commented out. Can possibly delete this
#func on_start_pressed() -> void:
	#get_tree().change_scene_to_packed(start_level)
	
#Reeha: Commented out. Can possibly delete this
#func on_exit_pressed() -> void:
	#get_tree().quit()
	

func on_exit_options_menu() -> void:
	pass


func _on_start_game_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/drag_and_drop_card_game/drag_drop_main.tscn")
	

func _on_exit_game_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/drag_and_drop_card_game/drag_drop_main.tscn")
	
#Reeha: Added this to change the visibility upon pressing settings button. Connection to settings menu
func _on_settings_button_down() -> void:
	margin_container.visible = false
	options_menu.visible = true
