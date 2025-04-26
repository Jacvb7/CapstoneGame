extends Control

# Reference to the OptionButton node in the UI
@onready var option_button: OptionButton = $HBoxContainer/OptionButton

# Array of window mode options available to the player
const WINDOW_MODE_ARRAY : Array[String] = [
	"Full-Screen",
	"Window mode",
	"Borderless Window",
	"Borderless Full-Screen"
]

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Populate the OptionButton with window mode choices
	add_window_mode_items()
	# Connect the item_selected signal to the handler function
	option_button.item_selected.connect(on_window_mode_selected)

# Adds window mode options to the OptionButton dropdown
func add_window_mode_items() -> void:
	for window_mode in WINDOW_MODE_ARRAY:
		option_button.add_item(window_mode)

# Called when a window mode is selected from the OptionButton
func on_window_mode_selected(index : int) -> void:
	match index:
		0: # Full-screen mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: # Windowed mode with borders
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: # Borderless windowed mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3: # Borderless full-screen mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
