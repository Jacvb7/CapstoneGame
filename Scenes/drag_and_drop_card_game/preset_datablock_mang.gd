# preset_datablock_mang.gd

extends Node2D

const PRESET_DATABLOCK_SCENE_PATH = "res://Scenes/drag_and_drop_card_game/preset_datablock.tscn"
const DATABLOCK_SLOT_SCENE_PATH = "res://Scenes/drag_and_drop_card_game/datablock_slot.tscn"

var bug_database_ref = preload("res://scripts/bug_database.gd").new()
var preset_blocks = []
var datablock_slots = []
var slot_to_preset_map = {}  # Maps slots to their corresponding preset blocks
var row_to_bug_map = {}      # Maps row indices to bug names
var col_to_attribute_map = {} # Maps column indices to attribute types

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize field columns and preset blocks
	initialize_preset_table()
	
	# Connect signals for validation
	var datablock_manager = get_node("../datablock_mang")
	if datablock_manager:
		datablock_manager.connect("datablock_placed_in_slot", _on_datablock_placed)
		datablock_manager.connect("datablock_removed_from_slot", _on_datablock_removed)

# Initialize the preset table with headers and example row
func initialize_preset_table():
	# Set up attribute mapping for columns 
	# Column 1 is for legs, Column 2 is for color
	col_to_attribute_map[1] = "legs"
	col_to_attribute_map[2] = "color"
	
	# Create header blocks (row 0)
	var field_names = bug_database_ref.get_preset_field_names()
	for col in range(field_names.size()):
		create_preset_block(0, col, "FIELDS", col)
	
	# Add FIZZGIG row as example (row 1)
	create_fizzgig_example_row(1, field_names.size())
	
	# Set up slots for remaining rows
	setup_data_slots(2, 7, field_names.size())  # Rows 2-6 for data entry

# Create a preset datablock at the given row and column
func create_preset_block(row, col, bug_name, field_index):
	var preset_block = preload(PRESET_DATABLOCK_SCENE_PATH).instantiate()
	add_child(preset_block)
	
	# Position the block in a grid layout
	var x_pos = 210 + col * 65  # Adjust spacing as needed
	var y_pos = 15 + row * 35  # Adjust spacing as needed
	preset_block.position = Vector2(x_pos, y_pos)
	
	# Set the displayed text based on what we're showing
	var display_text = bug_database_ref.get_preset_bug_data(bug_name, field_index)
	
	preset_block.initialize(display_text)
	preset_blocks.append(preset_block)

# Create FIZZGIG example row
func create_fizzgig_example_row(row, num_columns):
	for col in range(num_columns):
		create_preset_block(row, col, "FIZZGIG", col)
	
	# Map this row to the FIZZGIG bug
	row_to_bug_map[row] = "FIZZGIG"

# Set up slots for user-placed datablocks
func setup_data_slots(start_row, end_row, num_columns):
	var bugs = bug_database_ref.get_bug_names()
	var current_bug_index = 0
	
	for row in range(start_row, end_row):
		var bug_name = bugs[current_bug_index % bugs.size()]
		row_to_bug_map[row] = bug_name
		
		# Create name block for the row (column 0)
		create_preset_block(row, 0, bug_name, 0)
		
		# Create slots for data columns (columns 1 and 2)
		for col in range(1, num_columns):
			var slot = assign_datablock_slot(row, col)
			
			if slot:
				# Store validation data for this slot
				var attribute_type = col_to_attribute_map[col]
				var validation_data = create_validation_data(bug_name, attribute_type)
				slot_to_preset_map[slot] = validation_data
		
		current_bug_index += 1

# Use existing datablock slots in main
func assign_datablock_slot(row, col):
	# Find the appropriate slot in the main scene
	var slot_name = "datablock_slot_r" + str(row) + "c" + str(col)
	var slot = get_node("../" + slot_name)
	
	if slot:
		datablock_slots.append(slot)
		return slot
	else:
		print("Warning: Could not find slot " + slot_name)
		return null

# Create validation data structure for a slot
func create_validation_data(bug_name, attribute_type):
	return {
		"bug_name": bug_name,
		"attribute_type": attribute_type,
		"expected_value": bug_database_ref.get_bug_data(bug_name, attribute_type)
	}

# Update validation status of all placed datablocks
func update_validation():
	for slot in datablock_slots:
		if slot.datablock_in_slot:
			# Find the datablock in this slot
			var children = get_tree().get_nodes_in_group("datablocks")
			for child in children:
				if child.datablock_is_in_slot == slot:
					if slot in slot_to_preset_map:
						validate_datablock(child, slot_to_preset_map[slot])
					break

# Handle datablock placement with validation check
func _on_datablock_placed(datablock, slot):
	if slot in slot_to_preset_map:
		var validation_data = slot_to_preset_map[slot]
		var is_valid = validate_datablock(datablock, validation_data)
		
		if not is_valid:
			# If not valid, unlock the datablock from the slot
			_unlock_datablock(datablock, slot)

# Handle datablock removal
func _on_datablock_removed(datablock, old_slot):
	# Reset slot state
	if old_slot:
		old_slot.datablock_in_slot = false

# Validate if the datablock has the correct value for the slot
func validate_datablock(datablock, validation_data):
	if not datablock or not validation_data:
		return false
	
	var datablock_bug_name = datablock.bug_name
	var datablock_attribute = datablock.attribute_type
	var expected_bug_name = validation_data["bug_name"]
	var expected_attribute = validation_data["attribute_type"]
	
	# Check if the datablock matches the expected bug and attribute
	if datablock_attribute == expected_attribute:
		var value_text = ""
		if datablock_attribute == "legs":
			value_text = str(bug_database_ref.bug_data[datablock_bug_name]["legs"])
		elif datablock_attribute == "color":
			value_text = bug_database_ref.bug_data[datablock_bug_name]["color"]
		
		# Get the expected value from the row's bug
		var expected_value = ""
		if expected_attribute == "legs":
			expected_value = str(bug_database_ref.bug_data[expected_bug_name]["legs"])
		elif expected_attribute == "color":
			expected_value = bug_database_ref.bug_data[expected_bug_name]["color"]
		
		if value_text == expected_value:
			set_datablock_valid(datablock, true)
			return true
	
	# Invalid placement
	set_datablock_valid(datablock, false)
	return false

# Set visual feedback for validation
func set_datablock_valid(datablock, is_valid):
	if is_valid:
		# Set color to green for valid placement
		datablock.modulate = Color(0.7, 1.0, 0.7)  # Light green
	else:
		# Set color to red for invalid placement
		datablock.modulate = Color(1.0, 0.7, 0.7)  # Light red
		
	# Optional: Add animation for feedback
	var tween = get_tree().create_tween()
	if is_valid:
		# Subtle pulse animation for valid placement
		tween.tween_property(datablock, "scale", Vector2(0.95, 0.95), 0.2)
	else:
		# Shake animation for invalid placement
		var orig_pos = datablock.position
		tween.tween_property(datablock, "position", orig_pos + Vector2(5, 0), 0.05)
		tween.tween_property(datablock, "position", orig_pos - Vector2(5, 0), 0.05)
		tween.tween_property(datablock, "position", orig_pos, 0.05)

# Unlock a datablock from a slot if it's invalid
func _unlock_datablock(datablock, slot):
	# Reset the datablock state
	datablock.datablock_is_in_slot = null
	datablock.get_node("Area2D/CollisionShape2D").disabled = false
	datablock.z_index = 1
	datablock.scale = Vector2(1, 1)
	datablock.modulate = Color(1, 1, 1)  # Reset color
	
	# Reset the slot state
	slot.datablock_in_slot = false
	
	# Return the datablock to the unplaced area
	var unplaced_datablocks = get_node("../unplaced_datablocks")
	if unplaced_datablocks:
		unplaced_datablocks.add_new_datablock_to_place(datablock)
