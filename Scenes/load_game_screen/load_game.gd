class_name LoadGame
extends Control

@onready var Save_1: Button = $MarginContainer/HBoxContainer/VBoxContainer/Save_1
@onready var Save_2: Button = $MarginContainer/HBoxContainer/VBoxContainer/Save_2
@onready var  Save_3: Button = $MarginContainer/HBoxContainer/VBoxContainer/Save_3
@onready var Back: Button = $VBoxContainer/Back
#Reeha: Added these two variables below
#@onready var options_menu: OptionsMenu = $Options_Menu
#@onready var margin_container: MarginContainer = $MarginContainer

@onready var start_level = preload("res://Scenes/mainmenu/main_menu.tscn") as PackedScene

func _ready():
	# Jacob added new button configurations to the LoadGane script 
	Save_1.button_down.connect(_on_save_1_button_down)
	Save_2.button_down.connect(_on_save_2_button_down)
	Save_3.button_down.connect(_on_save_3_button_down)
	Back.button_down.connect(_on_back_button_down)
	#options_menu.exit_options_menu.connect(on_exit_options_menu)

func _process(delta: float) -> void:
	pass
	
#Reeha: Commented out. Can possibly delete this
#func on_start_pressed() -> void:
	#get_tree().change_scene_to_packed(start_level)
	
#Reeha: Commented out. Can possibly delete this
#func on_exit_pressed() -> void:
	#get_tree().quit()
	
#Reeha: Added this for the exit button. (Going from options screen back to main menu
#func on_exit_options_menu() -> void:
#	margin_container.visible = true
#	options_menu.visible = false
	


func _on_save_1_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/drag_and_drop_card_game/drag_drop_main.tscn")
	
func _on_save_2_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/drag_and_drop_card_game/drag_drop_test.tscn")
	
func _on_save_3_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/drag_and_drop_card_game/drag_drop_main.tscn")

func _on_back_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainmenu/main_menu.tscn")

# will be using this implementation below when we have working states available to use	
#Reeha: Added this to change the visibility upon pressing settings button. Connection to settings menu
#func _on_settings_button_down() -> void:
#	margin_container.visible = false
#	options_menu.set_process(true)
#	options_menu.visible = true
