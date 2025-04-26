class_name HotkeyRebindButton
extends Control

# References to the label and button nodes inside the UI
@onready var label: Label = $HBoxContainer/Label
@onready var button: Button = $HBoxContainer/Button

# Exported action name (default is "walk_left")
@export var action_name : String  = "walk_left"

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Disable unhandled key input until the player starts rebinding
	set_process_unhandled_key_input(false)
	# Set up the display name for the action
	set_action_name()
	# Display the current key bound to this action
	set_text_for_key()

# Sets the display name based on the action_name
func set_action_name() -> void:
	label.text = "Unassigned"
	match action_name:
		"walk_left" :
			label.text = "Move Left"
		"walk_right":
			label.text = "Move Right"
		"walk_up":
			label.text = "Move Up"
		"walk_down":
			label.text = "Move Down"

# Displays the key currently bound to this action
func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	button.text = "%s" % action_keycode

# Called when the button is toggled on or off
func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		# Enter "listening" mode for key rebinding
		button.text = "Press any key..."
		set_process_unhandled_key_input(toggled_on)
		# Disable rebinding on other hotkey buttons
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		# Restore normal mode for all buttons
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		set_text_for_key()

# Handles unhandled keyboard input during rebinding
func _unhandled_key_input(event):
	rebind_action_key(event)
	button.button_pressed = false

# Rebinds the selected action to the new key
func rebind_action_key(event) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
