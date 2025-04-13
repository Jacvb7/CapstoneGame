#This script handles logic for the settings screen
class_name OptionsMenu #Create a custom class for the Options Menu
extends Control

# Reference to the Back button inside the options menu
@onready var back_button: Button = $MarginContainer/VBoxContainer/Back_button

# Custom signal to inform the main menu to restore visibility and state
# (since this scene cannot fully reset the main menu by itself)
signal exit_options_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#connecting the exit button on button down to the function _on_exit_button_button_down
	back_button.button_down.connect(_on_exit_button_button_down)
	# Disable processing initially, so this script does not run until explicitly activated
	# Helps avoid input issues when the options menu is hidden
	set_process(false)


# Function triggered when the Exit button is pressed
func _on_exit_button_button_down() -> void:
	exit_options_menu.emit() # Emit the custom signal so the main menu can respond
	set_process(false) # Disable processing again, since the menu is being exited
	
