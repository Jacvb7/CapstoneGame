extends Control

# References to the label and the toggle button nodes
@onready var state_label: Label = $HBoxContainer/State_label
@onready var check_button: CheckButton = $HBoxContainer/CheckButton

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Connects the check button's toggled signal to the handler function
	check_button.toggled.connect(_on_check_button_toggled)

# Called when the CheckButton is toggled
func _on_check_button_toggled(toggled_on: bool) -> void:
	# Update the label to reflect the new state
	set_label_text(toggled_on)

# Updates the label text based on whether the button is toggled on or off
func set_label_text(button_pressed : bool) -> void:
	if button_pressed != true:
		state_label.text = "Off"
	else:
		state_label.text = "On"
