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
func get_datablock_slot_names(group_name: String):
	var nodes = get_tree().get_nodes_in_group(group_name)
	for node in nodes:
		print(node.name, " found at ", node.position)
