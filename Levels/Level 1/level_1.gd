# This script manages the level 1 game.
extends Node2D

# Reference to the interactable component system
@onready var interactable_component: InteractableComponent = $InteractableComponent
# Reference to the pause menu UI
@onready var pause_menu: Control = $CanvasLayer/Pause_Menu

#@onready var drag_drop_main: Node2D = $GameOverlayRoot/DragDropMain
# Reference to the player node
@onready var player: Player = $Player
# Reference to the bug scanner object (for visibility toggle)
@onready var bug_scanner_3000: Node2D = $bug_scanner_3000
# Controls whether the player can press "T" to open the minigame
var enable_T: bool = false

func _process(delta: float) -> void:
	on_esc_pressed()
	on_table_pressed()


# Called when the node enters the scene tree
func _ready() -> void:
	# Connect interaction signals to corresponding handlers
	interactable_component.interactable_activated.connect(interacting)
	interactable_component.interactable_deactivated.connect(deactivating)
	# If the mini-game has already been completed, restore player position and hide scanner
	if GlobalVariables.finish_mini_game:
		player.position = Vector2(GlobalVariables.player_pos_x, GlobalVariables.player_pos_y)
		bug_scanner_3000.visible = false


# Triggers pause menu when ESC is pressed and game is not already paused
func on_esc_pressed() -> void:
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()


# Activates the pause menu and pauses the game tree	
func pause():
	pause_menu.set_process(true)
	get_tree().paused = true


# Opens the drag-and-drop table minigame when T is pressed and player has the scanner		
func on_table_pressed() -> void: 
	if Input.is_action_just_pressed("table") and GlobalVariables.has_scanner and !GlobalVariables.finish_mini_game and !GlobalVariables.disable_T and GlobalVariables.minigame_ready:
		get_tree().change_scene_to_file("res://Scenes/drag_and_drop_card_game/drag_drop_main.tscn")
		GlobalVariables.enable_click = true


# Called when player enters interaction zone
func interacting() -> void:
	# Save player position in global variables
	GlobalVariables.player_pos_x = player.global_position.x
	GlobalVariables.player_pos_y = player.global_position.y
	
	enable_T = true
	GlobalVariables.minigame_ready = true
	print(GlobalVariables.minigame_ready)


# Called when player leaves the interaction zone
func deactivating() -> void:
	GlobalVariables.minigame_ready = false
	enable_T = false
