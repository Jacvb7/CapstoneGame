# preset_datablock.gd

extends Node2D

var bug_database_ref = preload("res://scripts/bug_database.gd").new()

@onready var text_label = $preset_datablock_text
@export var max_font_size: int = 24
@export var min_font_size: int = 10
@export var max_width: int = 60

# Font path
const FONT_PATH = "res://assets/fonts/Roboto-Regular.ttf"

var display_text = ""

func _ready():
	await get_tree().process_frame  # Ensure nodes are initialized
	set_text()

# Initialize the preset datablock with text
func initialize(text_value):
	display_text = text_value
	if text_label:
		text_label.text = display_text
		set_text()

# Dynamic text sizing (similar to your datablock implementation)
func set_text():
	var font = load(FONT_PATH)
	if not font:
		print("Error: Font not found at", FONT_PATH)
		return

	text_label.add_theme_font_override("font", font)
	text_label.add_theme_font_size_override("normal_font_size", min_font_size)
	
	var font_size = max_font_size
	var full_text = display_text if display_text else text_label.text
	
	# Add center formatting if not already present
	if not full_text.begins_with("[center]"):
		full_text = "[center]" + full_text + "[/center]"
	
	# Adjust font size dynamically
	while font_size >= min_font_size:
		text_label.add_theme_font_override("font", font)
		text_label.add_theme_font_size_override("normal_font_size", font_size)

		# Calculate the width of the text with the current font size
		var text_width = font.get_string_size(full_text, font_size).x
		
		if text_width > max_width:
			font_size -= 1
		else:
			break
	
	text_label.text = full_text
