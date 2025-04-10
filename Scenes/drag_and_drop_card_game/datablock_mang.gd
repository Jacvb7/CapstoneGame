# datablock_mang.gd
# https://youtu.be/2jMcuKdRh2w?si=1xDDcHiEXJ0qo9vr
# Description: Level 1 script that controls drag and drop functionality of datablocks and 
# unplaced_datablocks. Blocks are unplaced until they are placed in datablock_slots. 
# Regardless, this script controls the appearance of blocks as they are moved by the player.

extends Node2D

const COLLISION_MASK_DATABLOCK = 1
const COLLISION_MASK_DATABLOCK_SLOT = 2
const DEFAULT_DATABLOCK_SCALE = 1
const BIGGER_DATABLOCK_SCALE = 1.05
const SMALLER_DATABLOCK_SCALE = 0.95
const DEFAULT_DATABLOCK_COLOR = Color(1, 1, 1, 1)

var bug_database_ref = preload("res://scripts/bug_database.gd").new()

var screen_size
var datablock_being_dragged
var is_hovering_on_datablock
var unplayed_datablock_position_ref
var row
var col

# used to calculate the end of the L1 DS game
var correctlyPlacedTotal = 0
var totalBlocksBeingPlaced = bug_database_ref.total_blocks_being_placed()
var endGame = false

# gets the screen size and creates a reference to unplaced_datablocks.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	unplayed_datablock_position_ref = $"../unplaced_datablocks"

	# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
	dialogue_label = $"../RichTextLabel"  # Adjust the path


# get the mouse's position when datablock_being_dragged is occurring and 
# adjusts the z-position of dragged datablocks so they appear above everything else in the scene.
func _process(_delta: float) -> void:
	if datablock_being_dragged:
		#var mouse_pos = get_global_mouse_position()
		var mouse_pos = get_viewport().get_mouse_position()
		# keep player from dragging datablock offscreen where they cannot click on it
		datablock_being_dragged.position = Vector2(clamp(mouse_pos.x, 0, screen_size.x), 
			clamp(mouse_pos.y, 0, screen_size.y))
		# Ensure the dragged block always stays on top
		datablock_being_dragged.z_index = 10


#func _gui_input(event):
	#if event is InputEventMouseButton and event.pressed:
		#print("Clicked on draggable: ", name)
	#if not EnableVariables.dragging_enabled:
		#return  # Ignore all drag events when dragging is disabled
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.pressed:
			#var datablock = raycast_check_for_datablock()
			#if datablock:
				#start_drag(datablock)
		#else: # when left click released
			#if datablock_being_dragged:
				#finish_drag()


# allows for left mouse click and release to connect to start_drag and finish_drag methods.
func _input(event):
	#if not EnableVariables.dragging_enabled:
		#return  # Ignore all drag events when dragging is disabled
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var datablock = raycast_check_for_datablock()
			if datablock:
				start_drag(datablock)
		else: # when left click released
			if datablock_being_dragged:
				finish_drag()


# assigns the datablock being dragged to datablock_being_dragged which is used 
# in logic throughout the script, adjusts the scale of the dragged block, and 
# adjusts the z-position of dragged datablocks so they appear above everything else in the scene.
func start_drag(datablock):
	datablock_being_dragged = datablock
	datablock.scale = Vector2(DEFAULT_DATABLOCK_SCALE, DEFAULT_DATABLOCK_SCALE)
	# Ensures that datablock being dragged is above all other elements
	datablock.z_index = 10
	
	# Store the original color if it hasn't been stored yet
	if not datablock.has_meta("original_color"):
		datablock.set_meta("original_color", datablock.modulate)


# creates visual feedback for the player releasing a block and contains logic that 
# allows the player to move unplayed_datablocks to datablock_slots, move datablocks 
# from one slot to another, or return datablocks to the unplayed_datablock array at the bottom 
# of the scene. Also contains the beginning of logic for validation via method call to check_if_valid.
func finish_drag():
	datablock_being_dragged.scale = Vector2(BIGGER_DATABLOCK_SCALE, BIGGER_DATABLOCK_SCALE)
	var datablock_slot_found = raycast_check_for_datablock_slot()
	
	# If datablock is being moved from one slot to another, mark previous slot as empty
	if datablock_being_dragged.datablock_is_in_slot:
		
		datablock_being_dragged.datablock_is_in_slot.datablock_in_slot = false
		datablock_being_dragged.datablock_is_in_slot = null
	
	if datablock_slot_found and not datablock_slot_found.datablock_in_slot:
		
		# Set visual appearance when in slot
		datablock_being_dragged.scale = Vector2(SMALLER_DATABLOCK_SCALE, SMALLER_DATABLOCK_SCALE)
		datablock_being_dragged.z_index = -1
		
		# Datablock always snaps into empty slot
		datablock_being_dragged.datablock_is_in_slot = datablock_slot_found
		datablock_being_dragged.position = datablock_slot_found.position
		datablock_slot_found.datablock_in_slot = true
		
		# Remove from unplayed datablocks
		unplayed_datablock_position_ref.remove_datablock_from_unplayed_datablocks(datablock_being_dragged)
		
		# Validate data on block against bug name and feature value
		check_if_valid(datablock_being_dragged, datablock_slot_found)
		
	else:
		# No valid slot found, return datablock to unplaced section
		unplayed_datablock_position_ref.add_new_datablock_to_place(datablock_being_dragged)
		# Reset the z-index for unplaced datablocks
		datablock_being_dragged.z_index = 1
		datablock_being_dragged.scale = Vector2(DEFAULT_DATABLOCK_SCALE, DEFAULT_DATABLOCK_SCALE)
	
	datablock_being_dragged = null


# uses datablock_slot naming conventions in the scene to extract the row and column  
# number of the slot that a datablock was recently placed into.
func extract_row_and_col(slot_name):
	# Extract row and column using regex
	var regex = RegEx.new()
	regex.compile("r(\\d+)c(\\d+)")
	var result = regex.search(slot_name)
	
	if result:
		row = int(result.get_string(1))
		col = int(result.get_string(2))
	else:
		print("Could not extract row/col from:", slot_name)


# called in check_if_valid to format text in preset_datablocks for further processing.
func strip_bbcode_tags(text: String) -> String:
	return text.strip_edges().replace("[center]", "").replace("[/center]", "")


# sets is_valid to false, initialized row and col with extract_row_and_col method, 
# initializes bug_name with data from preset_datablock using naming conventions in 
# the scene, set is_valid to true or false using validate_bug_data method in bug_database.gd, 
# and visualizes feedback for player by calling visualize_validation_feedback.
func check_if_valid(dragged_datablock, datablock_slot_found):
	var is_valid = false
	var text_on_datablock = dragged_datablock.get_node("datablock_text")
	var data = text_on_datablock.text.strip_edges().replace("[center]", "").replace("[/center]", "")
	#print("Datablock ", dragged_datablock.name, ": \t", data) # example output: Datablock @Node2D@15: 	Red
	
	# extract row and column from slot that datablock was placed
	var slot_name = datablock_slot_found.name
	extract_row_and_col(slot_name)
	#print("Extracted row:", row, " | Extracted col:", col)
	
	# Use row to find the name of the bug in column 0 #preset_datablock_r6c0 	Position: (381, 248)	Text: TAFFY
	var bug_name = "preset_datablock_r" + str(row) + "c0"
	var nodes = get_tree().get_nodes_in_group("preset_datablocks")
	for node in nodes:
		if node.name == bug_name:
			var text_label = node.get_node("preset_datablock_text")
			bug_name = strip_bbcode_tags(text_label.text)  # Remove BBCode
			#print(bug_name, " is in preset datablock: ", node.name)
	
	if bug_name in bug_database_ref.get_bug_names():
		is_valid = bug_database_ref.validate_bug_data(bug_name, col, data)
		visualize_validation_feedback(datablock_being_dragged, is_valid)
		if is_valid:
			correctlyPlacedTotal += 1
			# print(correctlyPlacedTotal, " out of ", totalBlocksBeingPlaced, " have been placed in the table.\n")
		
	if correctlyPlacedTotal == totalBlocksBeingPlaced:
		endGame = true
	if endGame:
		#print("Congrats! You completed the game!")
		# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
		#update_dialogue("BYTE: You completed the table! Great job!")
		GlobalVariables.finish_mini_game = true


# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
var dialogue_label = ""
func update_dialogue(text: String):
	if dialogue_label:
		dialogue_label.text = text
	else:
		print("Dialogue label not found!")


# locks datablocks in slots if is_valid is true and briefly modulates the color to green, 
# otherwise allows further movement and modulates the color to red temporarily.
func visualize_validation_feedback(dragged_datablock, is_valid):
	# **Lock card in place if it's valid**
	if is_valid:
		dragged_datablock.get_node("Area2D/CollisionShape2D").disabled = true
	else:
		# Keep collision enabled so the player can pick it up again
		dragged_datablock.get_node("Area2D/CollisionShape2D").disabled = false
		
	# **Apply visual feedback: invalid=red, valid=green**
	var target_color = Color(0, 1, 0, 1) if is_valid else Color(1, 0, 0, 1)  # Green for valid, red for invalid
	var original_color = dragged_datablock.get_meta("original_color", DEFAULT_DATABLOCK_COLOR)
	
	dragged_datablock.modulate = target_color
	await get_tree().create_timer(0.3).timeout  # Wait 0.3 seconds
	dragged_datablock.modulate = original_color  # Restore original color


# connects signals from this script to parent script, datablock.gd.
func connect_datablock_signals(datablock):
	# THESE ARE CAUSING A WARNING:
	datablock.connect("hovered", on_hovered_over_datablock)
	datablock.connect("hovered_off", on_hovered_off_datablock)


# sets highlight_datablock to true and calls highlight_datablock to adjust the 
# scale and z-axis of the datablock.
func on_hovered_over_datablock(datablock):
	if !is_hovering_on_datablock:
		is_hovering_on_datablock = true
		highlight_datablock(datablock, true)


# detects if datablock has been placed into a vacant slot, calls highlight_datablock 
# to adjust the scale and z-axis of the datablock, and set is_hovering_on_datablock to false.
func on_hovered_off_datablock(datablock):
	# check if datablock is NOT in a slot AND NOT being dragged
	if !datablock.datablock_is_in_slot and !datablock_being_dragged:
		# if not dragging
		highlight_datablock(datablock, false)
		# check if hovered off one datablock and hovered onto another datablock
		var new_datablock_hovered = raycast_check_for_datablock() # return the card under the cursor
		if new_datablock_hovered:
			highlight_datablock(new_datablock_hovered, true)
		else:
			is_hovering_on_datablock = false


# adjust the scale and z-axis of the datablock
func highlight_datablock(datablock, hovered):
	if hovered:
		datablock.scale = Vector2(BIGGER_DATABLOCK_SCALE, BIGGER_DATABLOCK_SCALE)
		# adjust z-axis for when blocks cross one another
		datablock.z_index = 2
	else:
		datablock.scale = Vector2(DEFAULT_DATABLOCK_SCALE, DEFAULT_DATABLOCK_SCALE)
		# adjust z-axis for when blocks cross one another
		datablock.z_index = 1


# uses built in Godot class Raycast to find the location of slots in the scene. 
func raycast_check_for_datablock_slot():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	#parameters.position = get_global_mouse_position()
	parameters.position = get_viewport().get_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_DATABLOCK_SLOT
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		return result[0].collider.get_parent()
	else:
		return null


# uses raycast to return the object under the cursor when the player clicks on it.
func raycast_check_for_datablock():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_DATABLOCK
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		#return result[0].collider.get_parent()
		return get_datablock_with_highest_z_index(result)
	else:
		return null


# corrects bug in a program where overlapping blocks return an array of more than 
# one draggable datablock, and ensures that the datablock on top will be chosen as the drag object.
func get_datablock_with_highest_z_index(datablocks):
	# assumes that the first datblock in the raycast array has the highest z value
	var highest_z_datablock = datablocks[0].collider.get_parent()
	var highest_z_index = highest_z_datablock.z_index
	
	# loops through all datablocks for the block with the highest z index
	for i in range(1, datablocks.size()):
		var current_datablock = datablocks[i].collider.get_parent()
		if current_datablock.z_index > highest_z_index:
			highest_z_datablock = current_datablock
			highest_z_index = current_datablock.z_index
	
	return highest_z_datablock
