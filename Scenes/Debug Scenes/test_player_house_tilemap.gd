class_name testHouse
extends Control


@onready var margin_container: MarginContainer = $MarginContainer
@onready var pause_menu: Control = $GameTileMap/CanvasLayer/Pause_Menu

func _on_esc_button_down() -> void:
	#margin_container.visible = false
	pause_menu.set_process(true)
	pause_menu.visible = true
