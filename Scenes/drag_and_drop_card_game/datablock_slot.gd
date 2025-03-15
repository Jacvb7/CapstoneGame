# datablock_slot.gd

# https://youtu.be/QmTXsm1Tohg?si=DLzIr6fPqh2aZWB8

extends Node2D

var datablock_in_slot = false
var slot_is_valid = false
var global_group_name = "datablock_slots"
var slot_name = ""

func _ready():
	await get_tree().process_frame  # Ensure all preset datablocks update first
	
	#get_datablock_slot_names(global_group_name)


################################################################
## FUNCTION TO PRINT DATABLOCK_SLOT NAMES AND POSITION        ##
## PRINTS MULTIPLE TIMES BUT CONTAINS SYNTAX I MAY NEED LATER ##
################################################################
#datablock_slot_r2c1 found at (445, 120)
#datablock_slot_r2c2 found at (509, 120)
#datablock_slot_r3c1 found at (445, 152)
#datablock_slot_r3c2 found at (509, 152)
#datablock_slot_r4c1 found at (445, 184)
#datablock_slot_r4c2 found at (509, 184)
#datablock_slot_r5c1 found at (445, 216)
#datablock_slot_r5c2 found at (509, 216)
#datablock_slot_r6c1 found at (445, 248)
#datablock_slot_r6c2 found at (509, 248)
func get_datablock_slot_names(group_name: String):
	var nodes = get_tree().get_nodes_in_group(group_name)
	for node in nodes:
		print(node.name, " found at ", node.position)
