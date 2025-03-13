# https://youtu.be/2jMcuKdRh2w?si=1xDDcHiEXJ0qo9vr
# manages datablocks to allow user to drag and drop 
# datablock objects around the screen.

extends Node2D

const COLLISION_MASK_DATABLOCK = 1
const COLLISION_MASK_DATABLOCK_SLOT = 2
const DEFAULT_DATABLOCK_SCALE = 1
const BIGGER_DATABLOCK_SCALE = 1.05
const SMALLER_DATABLOCK_SCALE = 0.95

var screen_size
var datablock_being_dragged
var is_hovering_on_datablock
var unplayed_datablock_position_ref


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	unplayed_datablock_position_ref = $"../unplaced_datablocks"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if datablock_being_dragged:
		var mouse_pos = get_global_mouse_position()
		# keep player from dragging datablock offscreen where they cannot click on it
		datablock_being_dragged.position = Vector2(clamp(mouse_pos.x, 0, screen_size.x), 
			clamp(mouse_pos.y, 0, screen_size.y))
		# Ensure the dragged block always stays on top
		datablock_being_dragged.z_index = 10


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var datablock = raycast_check_for_datablock()
			if datablock:
				start_drag(datablock)
		else: # when left click released
			if datablock_being_dragged:
				finish_drag()


# Creates more visual feedback for player dragging a block
func start_drag(datablock):
	datablock_being_dragged = datablock
	datablock.scale = Vector2(DEFAULT_DATABLOCK_SCALE, DEFAULT_DATABLOCK_SCALE)
	# Ensures that datablock being dragged is above all other elements
	datablock.z_index = 10


# Creates more visual feedback for player releasing a block
func finish_drag():
	datablock_being_dragged.scale = Vector2(BIGGER_DATABLOCK_SCALE, BIGGER_DATABLOCK_SCALE)
	var datablock_slot_found = raycast_check_for_datablock_slot()
	
	# temporary variable for testing before validation signals/methods are applied
	var is_valid = false
	
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
		
		# Lock card in place ONLY if it's valid
		if is_valid:
			datablock_being_dragged.get_node("Area2D/CollisionShape2D").disabled = true
		else:
			# Keep collision enabled so the player can pick it up again
			datablock_being_dragged.get_node("Area2D/CollisionShape2D").disabled = false
	else:
		# No valid slot found, return datablock to unplaced section
		unplayed_datablock_position_ref.add_new_datablock_to_place(datablock_being_dragged)
		# Reset the z-index for unplaced datablocks
		datablock_being_dragged.z_index = 1
		datablock_being_dragged.scale = Vector2(DEFAULT_DATABLOCK_SCALE, DEFAULT_DATABLOCK_SCALE)
	
	datablock_being_dragged = null


func connect_datablock_signals(datablock):
	datablock.connect("hovered", on_hovered_over_datablock)
	datablock.connect("hovered_off", on_hovered_off_datablock)


func on_hovered_over_datablock(datablock):
	if !is_hovering_on_datablock:
		is_hovering_on_datablock = true
		highlight_datablock(datablock, true)


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


func highlight_datablock(datablock, hovered):
	if hovered:
		datablock.scale = Vector2(BIGGER_DATABLOCK_SCALE, BIGGER_DATABLOCK_SCALE)
		# adjust z-axis for when blocks cross one another
		datablock.z_index = 2
	else:
		datablock.scale = Vector2(DEFAULT_DATABLOCK_SCALE, DEFAULT_DATABLOCK_SCALE)
		# adjust z-axis for when blocks cross one another
		datablock.z_index = 1


func raycast_check_for_datablock_slot():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_DATABLOCK_SLOT
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		return result[0].collider.get_parent()
	else:
		return null


# set up raycast to return object under the cursor when we click on it
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


# Corrects bug in program where overlapping blocks return an array of more than one draggable datablocks. 
# This function ensure that the datablock on top will be chosen as the drag object.
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
