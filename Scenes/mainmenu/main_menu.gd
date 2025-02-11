class_name MainMenu
extends Control

@onready var start_game: Button = $MarginContainer/HBoxContainer/VBoxContainer/Button1 as Button
@onready var exit_game: Button = $MarginContainer/HBoxContainer/VBoxContainer/Button2 as Button
#@onready var settings: Button = $MarginContainer/HBoxContainer/VBoxContainer/Button3

@onready var start_level = preload("res://Scenes/mainmenu/main_menu.tscn") as PackedScene

func _ready():
	start_game.button_down.connect(on_start_pressed)
	exit_game.button_down.connect(on_exit_pressed)

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)
	

func on_exit_pressed() -> void:
	get_tree().quit()
