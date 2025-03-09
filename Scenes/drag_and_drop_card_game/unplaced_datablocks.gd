# unplaced_datablocks.gd

# https://youtu.be/lATAS8YpzFE?si=mD7kWHaMV-GZMf4v

extends Node2D

const TOTAL_DATABLOCKS = 10
const DATABLOCK_SCENE_PATH = "res://Scenes/drag_and_drop_card_game/datablock.tscn"
const DATABLOCK_WIDTH = 65 # space between datablocks
const UNPLAYED_Y_POSITION = 270

var unplayed_datablocks = []
var center_screen_x
var bug_database_ref = preload("res://scripts/bug_database.gd").new()
var bug_names = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_screen_x = get_viewport_rect().size.x / 2
	var datablock_scene = preload(DATABLOCK_SCENE_PATH)

	# Get bug names from database
	bug_names = bug_database_ref.get_bug_names()
	
	# Create datablocks for each bug, one for legs and one for color
	for i in range(TOTAL_DATABLOCKS / 2):  # Divide by 2 since each bug makes 2 datablocks
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


func add_new_datablock_to_place(datablock):
	if datablock not in unplayed_datablocks:
		unplayed_datablocks.insert(0, datablock)
		update_unplayed_datablocks_positions()
	else:
		animate_datablock_to_position(datablock, datablock.unplayed_datablock_position)


#func update_unplayed_datablocks_positions():
	#for i in range(unplayed_datablocks.size()):
		## get new datablock position based on index
		#var new_position = Vector2(calculate_datablock_position(i), UNPLAYED_Y_POSITION)
		#var current_datablock = unplayed_datablocks[i]
		#current_datablock.unplayed_datablock_position = new_position
		#animate_datablock_to_position(current_datablock, new_position)


#func calculate_datablock_position(index):
	#var total_width = (unplayed_datablocks.size() - 1) * DATABLOCK_WIDTH
	#var x_offset = center_screen_x + index * DATABLOCK_WIDTH - total_width / 2
	#return x_offset


func update_unplayed_datablocks_positions():
	var total_datablocks = unplayed_datablocks.size()
	for i in range(total_datablocks):
		if i < ceil(total_datablocks/2):
			# get new datablock position based on index for row 1
			var new_position = Vector2(calculate_datablock_position(i), UNPLAYED_Y_POSITION)
			var current_datablock = unplayed_datablocks[i]
			current_datablock.unplayed_datablock_position = new_position
			animate_datablock_to_position(current_datablock, new_position)
		else:
			# get new datablock position based on index for row 1
			var new_position = Vector2(calculate_datablock_position(i), UNPLAYED_Y_POSITION + 50)
			var current_datablock = unplayed_datablocks[i]
			current_datablock.unplayed_datablock_position = new_position
			animate_datablock_to_position(current_datablock, new_position)


func calculate_datablock_position(index):
	var total_datablocks = unplayed_datablocks.size()
	var total_width = (total_datablocks / 2 - 1) * DATABLOCK_WIDTH
	var x_offset
	if index < ceil(total_datablocks / 2):
		x_offset = center_screen_x + index * DATABLOCK_WIDTH - total_width / 2
	else:
		x_offset = center_screen_x + (total_datablocks - index - 1) * DATABLOCK_WIDTH - total_width / 2
	return x_offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func animate_datablock_to_position(current_datablock, new_position):
	var tween = get_tree().create_tween()
	# arguments passed: object, start position, end position, velocity
	tween.tween_property(current_datablock, "position", new_position, 0.2)


func remove_datablock_from_unplayed_datablocks(current_datablock):
	if current_datablock in unplayed_datablocks:
		unplayed_datablocks.erase(current_datablock)
		update_unplayed_datablocks_positions()
