# unplaced_datablocks.gd
# https://youtu.be/lATAS8YpzFE?si=mD7kWHaMV-GZMf4v
# Description: Level 1 script that dynamically instantiates and animates 
# unplaced datablocks in the scene. Constants at the beginning of the script 
# adjust the amount of blocks that are created and how quickly they appear on 
# the screen. Stores unplaced datablocks in an array which is updated as datablocks 
# are placed into or removed from datablock_slots.

extends Node2D

const TOTAL_DATABLOCKS = 10
# controls the animation of blocks appearing on screen
const SPEED_OF_MOVEMENT = 0.4 # smaller values move the blocks faster
const DATABLOCK_SCENE_PATH = "res://Scenes/drag_and_drop_card_game/datablock.tscn"
const DATABLOCK_WIDTH = 63 # space between datablocks
const UNPLAYED_Y_POSITION = 305 # position of blocks from the bottom of the scene
const CENTER_SCREEN_ADJUSTMENT = -13 # magic number that assists in centering the blocks

var unplayed_datablocks = []
var center_screen_x
var bug_database_ref = preload("res://scripts/bug_database.gd").new()
var bug_names = []

# finds center of the scene an initialized the array
func _ready() -> void:
	center_screen_x = get_viewport_rect().size.x / 2 + CENTER_SCREEN_ADJUSTMENT
	var datablock_scene = preload(DATABLOCK_SCENE_PATH)

	# Get bug names from database
	bug_names = bug_database_ref.get_bug_names()
	#bug_names.shuffle()
	
	# Create a list to hold datablocks before shuffling
	var all_datablocks = []
	
	# Create datablocks for each bug, one for legs and one for color
	for i in range(int(float(TOTAL_DATABLOCKS) / 2)):  # Divide by 2 since each bug makes 2 datablocks
		var assigned_bug = bug_names[i % bug_names.size()]
		
		# Create Legs Datablock
		var legs_datablock = datablock_scene.instantiate()
		# After instantiating the datablock, defer setting its data
		legs_datablock.call_deferred("set_bug_data", assigned_bug, "legs")
		#legs_datablock.set_bug_data(assigned_bug, "legs")
		all_datablocks.append(legs_datablock)  # Add to the list before shuffling
		
		# Create Color Datablock
		var color_datablock = datablock_scene.instantiate()
		# After instantiating the datablock, defer setting its data
		color_datablock.call_deferred("set_bug_data", assigned_bug, "color")
		#color_datablock.set_bug_data(assigned_bug, "color")
		all_datablocks.append(color_datablock)  # Add to the list before shuffling
	
	# Shuffle the datablocks so they appear in a random order
	all_datablocks.shuffle()
	
	# Now add shuffled datablocks to the scene
	for datablock in all_datablocks:
		datablock.scale = Vector2(1, 1)
		$"../datablock_mang".add_child(datablock)
		#datablock.raise()
		print(datablock.z_index)
		add_new_datablock_to_place(datablock)

func input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Datablock clicked!")
		
#############################################################
## FOR DEBUGGING                                           ##
## FUNCTION TO PRINT DATABLOCK NAMES AND THEIR TEXT LABELS ##
#############################################################
func print_array_contents():
	for unplayed in unplayed_datablocks:
		await get_tree().process_frame  # Ensure positions are updated
		#print("Children of ", unplayed.name, ": ", unplayed.get_children()) # Debugging
		# Corrected path: Look for 'datablock_text' instead of 'RichTextLabel'
		var rich_text_label = unplayed.get_node("datablock_text")
		if rich_text_label:
			var clean_text = rich_text_label.text.strip_edges().replace("[center]", "").replace("[/center]", "")
			print("Datablock ", unplayed.name, ": \t", clean_text)
		else:
			print(" -> [No RichTextLabel Found]")


# updates unplayed_datablocks array when datablocks are removed from datablock_slots, 
# and updates the position of unplayed_datablocks when datablock is returned to the bottom of the screen.
func add_new_datablock_to_place(datablock):
	if datablock not in unplayed_datablocks:
		unplayed_datablocks.insert(0, datablock)
		update_unplayed_datablocks_positions()
	else:
		animate_datablock_to_position(datablock, datablock.unplayed_datablock_position)


# updates unplayed_datablocks array when datablocks are placed in datablock_slots, 
# and updates the position of unplayed_datablocks after removal.
func remove_datablock_from_unplayed_datablocks(current_datablock):
	if current_datablock in unplayed_datablocks:
		unplayed_datablocks.erase(current_datablock)
		update_unplayed_datablocks_positions()


# called by add_new_datablock_to_place and remove_datablock_from_unplayed_datablocks to 
# calculate position of unplayed datablocks and animate their movement.
# Creates a single row of blocks at the bottom of the scene.
func update_unplayed_datablocks_positions():
	for i in range(unplayed_datablocks.size()):
		# get new datablock position based on index
		var new_position = Vector2(calculate_datablock_position(i), UNPLAYED_Y_POSITION)
		var current_datablock = unplayed_datablocks[i]
		current_datablock.unplayed_datablock_position = new_position
		animate_datablock_to_position(current_datablock, new_position)

# called by update_unplayed_datablocks_positions to make position calculations
# for a single row of blocks at the bottom of the scene.
func calculate_datablock_position(index):
	var total_width = (unplayed_datablocks.size() - 1) * DATABLOCK_WIDTH
	var x_offset = center_screen_x + index * DATABLOCK_WIDTH - int(float(total_width) / 2)
	return x_offset


# animates nodes in the scene using a Godot’s built in class, Tween.
func animate_datablock_to_position(current_datablock, new_position):
	var tween = get_tree().create_tween()
	# arguments passed: object, start position, end position, velocity
	tween.tween_property(current_datablock, "position", new_position, SPEED_OF_MOVEMENT)
	

#############################################################
## THIS VERSION OF FUNCTION INSTANTIATES 2 ROWS OF BLOCKS  ##
#############################################################
#func update_unplayed_datablocks_positions():
	#var total_datablocks = unplayed_datablocks.size()
	#for i in range(total_datablocks):
		#if i < ceil(total_datablocks/2):
			## get new datablock position based on index for row 1
			#var new_position = Vector2(calculate_datablock_position(i), UNPLAYED_Y_POSITION)
			#var current_datablock = unplayed_datablocks[i]
			#current_datablock.unplayed_datablock_position = new_position
			#animate_datablock_to_position(current_datablock, new_position)
		#else:
			## get new datablock position based on index for row 1
			#var new_position = Vector2(calculate_datablock_position(i), UNPLAYED_Y_POSITION + 50)
			#var current_datablock = unplayed_datablocks[i]
			#current_datablock.unplayed_datablock_position = new_position
			#animate_datablock_to_position(current_datablock, new_position)

#######################################################################
## USED BY THE 2ND VERSION OF update_unplayed_datablocks_positions() ##
## THAT INSTANTIATES 2 ROWS OF UNPLACED BLOCKS INSTEAD OF ONE.       ##
#######################################################################
#func calculate_datablock_position(index):
	#var total_datablocks = unplayed_datablocks.size()
	#var total_width = (total_datablocks / 2 - 1) * DATABLOCK_WIDTH
	#var x_offset
	#if index < ceil(total_datablocks / 2):
		#x_offset = center_screen_x + index * DATABLOCK_WIDTH - total_width / 2
	#else:
		#x_offset = center_screen_x + (total_datablocks - index - 1) * DATABLOCK_WIDTH - total_width / 2
	#return x_offset
