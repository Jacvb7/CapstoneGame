class_name testHouse
extends Control

@onready var pause_menu: pauseMenu = $Pause_Menu
@onready var margin_container: MarginContainer = $MarginContainer

func _on_esc_button_down() -> void:
	#margin_container.visible = false
	pause_menu.set_process(true)
	pause_menu.visible = true
