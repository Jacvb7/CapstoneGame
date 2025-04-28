extends Control

# Reference to the OptionButton node in the UI
@onready var option_button: OptionButton = $HBoxContainer/OptionButton

# Dictionary mapping resolution text to actual Vector2i screen sizes
const RESOLUTION_DICTIONARY : Dictionary = {
	"1280 x 720" : Vector2i(1280, 720),
	"1152 x 648" : Vector2i(1152, 648),   # Vector2i ensures resolution values are integers
	"1920 x 1080" : Vector2i(1920, 1080)
}

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Populate the OptionButton with resolution choices
	add_resolution_items()
	# Connect the selected item signal to the handler function
	option_button.item_selected.connect(on_resolution_selected)

# Adds resolution options to the OptionButton dropdown
func add_resolution_items() -> void:
	for res_size_text in RESOLUTION_DICTIONARY:
		option_button.add_item(res_size_text)

# Called when a resolution is selected from the OptionButton
func on_resolution_selected(index : int) -> void:
	# Sets the game window size based on the selected resolution
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
