# https://youtu.be/2jMcuKdRh2w?si=1xDDcHiEXJ0qo9vr

extends Node2D

const COLLISION_MASK_BLOCK = 1

var screen_size
var block_being_dragged


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if block_being_dragged:
		var mouse_pos = get_global_mouse_position()
		# keep player from dragging block offscreen where they cannot click on it
		block_being_dragged.position = Vector2(clamp(mouse_pos.x, 0, screen_size.x), 
			clamp(mouse_pos.y, 0, screen_size.y))


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# returns name and collider id for each object instance
			var block = raycast_check_for_datablock()
			if block:
				block_being_dragged = block
		else:
			# print("left click released")
			block_being_dragged = null

# set up raycast to return object under the cursor when we click on it
func raycast_check_for_datablock():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_BLOCK
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		# print(result[0].collider.get_parent())
		return result[0].collider.get_parent()
	else:
		return null
