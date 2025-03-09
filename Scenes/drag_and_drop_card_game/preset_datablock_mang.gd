# preset_datablock_mang.gd

extends Node2D

var preset_datablock_ref = preload("res://Scenes/drag_and_drop_card_game/preset_datablock.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Check bug's name from column 0
# Check field: c1 = total legs, c2 = color
func get_validation_data_from_preset_table():
	pass


# Assign existing datablock slots in main for validation
func assign_datablock_slot(row, col):
	pass


# Handle datablock placement with validation check
func _on_datablock_placed(datablock, slot):
	pass


# Validate if the datablock has the correct value for the slot
# finish_drag() in datablock_mang.gd always locks the block into the slot
func validate_datablock(datablock, validation_data):
	pass


# Unlock a datablock from it's slot if placement is invalid
func _unlock_datablock_from_slot(datablock, slot):
	pass


# Handle datablock removal for invalid placed datablocks
func _on_datablock_removed_from_slot(datablock, old_slot):
	pass
