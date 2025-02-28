class_name MainMenu
extends Control

#@onready var start_game: Button = $MarginContainer/HBoxContainer/VBoxContainer/Button1 as Button
#@onready var exit_game: Button = $MarginContainer/HBoxContainer/VBoxContainer/Button2 as Button
#@onready var settings: Button = $MarginContainer/HBoxContainer/VBoxContainer/Button3

@onready var start_level = preload("res://Scenes/mainmenu/main_menu.tscn") as PackedScene

func _ready():
	#start_game.button_down.connect(on_start_pressed)
	#exit_game.button_down.connect(on_exit_pressed)
	pass

#func on_start_game_pressed() -> void:
	#get_tree().change_scene_to_packed(start_level)
	#get_tree().change_scene_to_file("res://Scenes/drag_and_drop_card_game/drag_drop_main.tscn")

func on_exit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/user settings screen/settings.tscn")


func _on_start_game_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/drag_and_drop_card_game/drag_drop_main.tscn")
	
func _on_exit_game_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/drag_and_drop_card_game/drag_drop_main.tscn")
