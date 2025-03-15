# unplaced_datablocks.gd
# https://youtu.be/lATAS8YpzFE?si=mD7kWHaMV-GZMf4v

extends Node2D

const TOTAL_DATABLOCKS = 10
# controls the animation of blocks appearing on screen
const SPEED_OF_MOVEMENT = .3 # smaller values move the blocks faster
const DATABLOCK_SCENE_PATH = "res://Scenes/drag_and_drop_card_game/datablock.tscn"
const DATABLOCK_WIDTH = 63 # space between datablocks
const UNPLAYED_Y_POSITION = 315 # position of blocks from the bottom of the scene
const CENTER_SCREEN_ADJUSTMENT = -13 # magic number that assists in centering the blocks

var unplayed_datablocks = []
var center_screen_x
var bug_database_ref = preload("res://scripts/bug_database.gd").new()
var bug_names = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_screen_x = get_viewport_rect().size.x / 2 + CENTER_SCREEN_ADJUSTMENT
	var datablock_scene = preload(DATABLOCK_SCENE_PATH)

	# Get bug names from database
	bug_names = bug_database_ref.get_bug_names()
	
	# Create datablocks for each bug, one for legs and one for color
	for i in range(int(float(TOTAL_DATABLOCKS) / 2)):  # Divide by 2 since each bug makes 2 datablocks
		var assigned_bug = bug_names[i % bug_names.size()]
		
		# Create Legs Datablock
		var legs_datablock = datablock_scene.instantiate()
		legs_datablock.scale = Vector2(1, 1)
		$"../datablock_mang".add_child(legs_datablock)
		legs_datablock.set_bug_data(assigned_bug, "legs")
		add_new_datablock_to_place(legs_datablock)
		
		# Create Color Datablock
		var color_datablock = datablock_scene.instantiate()
		color_datablock.scale = Vector2(1, 1)
		$"../datablock_mang".add_child(color_datablock)
		color_datablock.set_bug_data(assigned_bug, "color")
		add_new_datablock_to_place(color_datablock)
		
		# print the array for debugging
		print_array_contents()

#############################################################
## FUNCTION TO PRINT DATABLOCK NAMES AND THEIR TEXT LABELS ##
#############################################################
#Datablock @Node2D@17: 	8
#Datablock @Node2D@17: 	8
#Datablock @Node2D@17: 	8
#Datablock @Node2D@15: 	Red
#Datablock @Node2D@15: 	Red
#Datablock @Node2D@15: 	Red
#Datablock @Node2D@15: 	Red
#Datablock @Node2D@15: 	Red
#Datablock datablock: 	6
#Datablock datablock: 	6
#Datablock datablock: 	6
#Datablock datablock: 	6
#Datablock datablock: 	6
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


func add_new_datablock_to_place(datablock):
	if datablock not in unplayed_datablocks:
		unplayed_datablocks.insert(0, datablock)
		update_unplayed_datablocks_positions()
	else:
		animate_datablock_to_position(datablock, datablock.unplayed_datablock_position)


func remove_datablock_from_unplayed_datablocks(current_datablock):
	if current_datablock in unplayed_datablocks:
		unplayed_datablocks.erase(current_datablock)
		update_unplayed_datablocks_positions()


# ORIGINAL VERSION OF THIS FUNCTION INSTANTIATES A SINGLE ROW OF BLOCKS TO BE PLACED
func update_unplayed_datablocks_positions():
	for i in range(unplayed_datablocks.size()):
		# get new datablock position based on index
		var new_position = Vector2(calculate_datablock_position(i), UNPLAYED_Y_POSITION)
		var current_datablock = unplayed_datablocks[i]
		current_datablock.unplayed_datablock_position = new_position
		animate_datablock_to_position(current_datablock, new_position)

# THIS FUNCTION IS USED BY THE ORIGINAL update_unplayed_datablocks_positions() THAT INSTANTIATES 
# A SINGLE ROW OF UNPLACED BLOCKS INSTEAD OF 2 ROWS (SEE BELOW)
func calculate_datablock_position(index):
	var total_width = (unplayed_datablocks.size() - 1) * DATABLOCK_WIDTH
	var x_offset = center_screen_x + index * DATABLOCK_WIDTH - int(float(total_width) / 2)
	return x_offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func animate_datablock_to_position(current_datablock, new_position):
	var tween = get_tree().create_tween()
	# arguments passed: object, start position, end position, velocity
	tween.tween_property(current_datablock, "position", new_position, SPEED_OF_MOVEMENT)
	
	
	## THIS VERSION OF FUNCTION INSTANTIATES A 2 ROWS OF BLOCKS TO BE PLACED
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


## THIS FUNCTION IS USED BY THE 2ND VERSION OF update_unplayed_datablocks_positions() THAT INSTANTIATES 
# A 2 ROWS OF UNPLACED BLOCKS INSTEAD OF ONE. (SEE ABOVE)
#func calculate_datablock_position(index):
	#var total_datablocks = unplayed_datablocks.size()
	#var total_width = (total_datablocks / 2 - 1) * DATABLOCK_WIDTH
	#var x_offset
	#if index < ceil(total_datablocks / 2):
		#x_offset = center_screen_x + index * DATABLOCK_WIDTH - total_width / 2
	#else:
		#x_offset = center_screen_x + (total_datablocks - index - 1) * DATABLOCK_WIDTH - total_width / 2
	#return x_offset
