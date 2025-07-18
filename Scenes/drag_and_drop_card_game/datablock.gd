# datablock.gd
# https://youtu.be/1mM73u1tvpU?si=z1QizoPoQK9xzoC2
# Description: script to attatch signals to the datablock_mang

extends Node2D

signal hovered
signal hovered_off

var unplayed_datablock_position
var datablock_is_in_slot

var bug_database_ref = preload("res://scripts/bug_database.gd").new()
var bug_name = ""  # Name of the bug assigned to this datablock
var attribute_type = ""  # Will store "legs" or "color"

# Code from chatGPT to dynamically control text point size in datablocks
# https://chatgpt.com/share/67c4865e-beb0-800f-9681-e511ad29d4f6
@onready var text_label = $datablock_text
@export var max_font_size: int = 24  # Set max font size
@export var min_font_size: int = 10 # Prevent text from getting too small
@export var max_width: int = 60  # Adjust to match your datablock width

# Font path
const FONT_PATH = "res://assets/fonts/Roboto-Regular.ttf"

# waits for datablocks to be initialized before apply text values to their RichTextLabels.
func _ready():
	await get_tree().process_frame  # Ensure the scene tree updates
	text_label = $datablock_text  # Try assigning again in case it was null
	
	update_text()
	set_text()
	
	# Attach signals
	if get_parent():
		get_parent().connect_datablock_signals(self)

# used in unplaced_datablocks.gd to instantiate “legs” and “color” datablocks.
func set_bug_data(bug, attr_type):
	bug_name = bug
	attribute_type = attr_type
	
	if text_label == null:
		await get_tree().process_frame  # Wait for scene tree to update
		text_label = $datablock_text  # Try assigning again
	
	update_text()
	set_text()
	
# connects to bug database to print feature values onto instantiated unplaced blocks.
func update_text():
	if bug_name in bug_database_ref.bug_data:
		var bug_info = bug_database_ref.bug_data[bug_name]
		
		if attribute_type == "legs":
			text_label.text = "[center]" + str(bug_info["legs"]) + "[/center]"
		elif attribute_type == "color":
			text_label.text = "[center]" + bug_info["color"] + "[/center]"


# emits a signal when mouse hovers over unplaced datablocks.
func _on_area_2d_mouse_entered() -> void:
	#print("hover signal emitted")  # Debugging
	emit_signal("hovered", self)

# emits a signal when mouse hovers off of unplaced datablocks.
func _on_area_2d_mouse_exited() -> void:
	#print("hover_off signal emitted")  # Debugging
	emit_signal("hovered_off", self)


# Code from chatGPT to dynamically control text point size in datablocks
# https://chatgpt.com/share/67c4865e-beb0-800f-9681-e511ad29d4f6
func set_text():
	var font = load(FONT_PATH)  # Load font correctly
	if not font:
		print("Error: Font not found at", FONT_PATH)
		return

	#var font_size = max_font_size
	text_label.add_theme_font_override("font", font)
	text_label.add_theme_font_size_override("normal_font_size", min_font_size)
	
	var font_size = max_font_size
	var full_text = text_label.text
	
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
