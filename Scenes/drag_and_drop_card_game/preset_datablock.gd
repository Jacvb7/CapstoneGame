# preset_datablock.gd
extends Node2D
var bug_database_ref = preload("res://scripts/bug_database.gd").new()
@onready var ALBY: Sprite2D = $"../Alby"
@onready var BIX: Sprite2D = $"../Bix"
@onready var EMBER: Sprite2D = $"../Ember"
@onready var FIZZGIG: Sprite2D = $"../Fizzgig"
@onready var NOX: Sprite2D = $"../Nox"
@onready var TAFFY: Sprite2D = $"../Taffy"

#new added
@onready var ember_label: Label = $"../../EmberLabel"
@onready var bix_label: Label = $"../../BixLabel"
@onready var fizzgig_label: Label = $"../../FizzgigLabel"
@onready var nox_label: Label = $"../../NoxLabel"
@onready var taffy_label: Label = $"../../TaffyLabel"
@onready var alby_label: Label = $"../../AlbyLabel"

var bug_images = {
	"Alby": ALBY,
	"Bix": BIX,
	"Ember": EMBER,
	"Fizzgig": FIZZGIG,
	"Nox": NOX,
	"Taffy": TAFFY
}
@onready var text_label = $preset_datablock_text
@export var max_font_size: int = 24
@export var min_font_size: int = 10
@export var max_width: int = 60
@onready var button: Button = $Button
@onready var sprite_2d: Sprite2D = $Button/Sprite2D
# Font path
const FONT_PATH = "res://assets/fonts/Roboto-Regular.ttf"
var display_text = ""
func _ready():
	await get_tree().process_frame  # Ensure nodes are initialized
	update_text()
	set_text()
var bug = ""
func update_text():
	var block_name
	if !is_in_group("preset_datablocks"):
		block_name = name  # Get the name of the node (e.g., "preset_datablock_r0c0")
		## FOR DEBUGGING
		#print("PRESET_DATABLOCK NOT FOUND: ", block_name)
	else:
		block_name = name  # Get the name of the node (e.g., "preset_datablock_r0c0")
		# print(block_name)
		# Extract row and column indices from the block name using split()
		var parts = block_name.split("_r")  # ["preset_datablock", "0c0"]
		if parts.size() > 1:
			var row_col = parts[1].split("c")  # ["0", "0"]
			if row_col.size() > 1:
				var row = int(row_col[0])
				var col = int(row_col[1])
				# First row: Set column headers
				if row == 0:
					var fields = bug_database_ref.preset_bug_data["FIELDS"]
					if col < fields.size():
						text_label.text = "[center]" + fields[col] + "[/center]"
				# Second row: Fill in all data for ALBY the example bug
				elif row == 1:
					var example_bug = bug_database_ref.preset_bug_data["EXAMPLE_BUG"]
					if col < example_bug.size():
						text_label.text = "[center]" + example_bug[col] + "[/center]"
						bug = example_bug[col] #Store the name in a global variable
						button.button_down.connect(_on_bug_button_pressed) #When the name is pressed.
						button.modulate.a = 0.1 # Changing visibility of the button. Only for aesthetics.
				# Fill in the rest of the first column with bug names
				
				######connect the names to the bugs##########
				elif row >= 2 and col == 0:
					var name_list = bug_database_ref.get_bug_names()
					if row - 2 < name_list.size():
						var bug_name = name_list[row - 2]# Name of bug
						text_label.text = "[center]" + bug_name + "[/center]"
						bug = bug_name	#Store the name in a global variable
						button.button_down.connect(_on_bug_button_pressed)	#When the name is pressed.
						
# Function that displays the selected bugs.
# It just uses a switch statement with the bug variable.
# The bug variable stores the name of the bug currently selected.
func _on_bug_button_pressed() -> void:
	match bug:
		"ALBY":
			hide_bugs()
			ALBY.show()
			alby_label.show()
		"BIX":
			hide_bugs()
			BIX.show()
			bix_label.show()
		"EMBER":
			hide_bugs()
			EMBER.show()
			ember_label.show()
		"FIZZGIG":
			hide_bugs()
			FIZZGIG.show()
			fizzgig_label.show()
		"NOX":
			hide_bugs()
			NOX.show()
			nox_label.show()
		"TAFFY":
			hide_bugs()
			TAFFY.show()
			taffy_label.show()
#function to hide all bugs
func hide_bugs() -> void:
	ALBY.hide()
	BIX.hide()
	EMBER.hide()
	FIZZGIG.hide()
	NOX.hide()
	TAFFY.hide()
	alby_label.hide()
	bix_label.hide()
	ember_label.hide()
	fizzgig_label.hide()
	nox_label.hide()
	taffy_label.hide()
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
