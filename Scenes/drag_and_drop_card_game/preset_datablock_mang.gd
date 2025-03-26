# preset_datablock_mang.gd
# Description: Level 1 script that previously contained validation operations. 
# Contains an unused reference to preset_datablock.gd and functions to access 
# coordinates and text labels.

extends Node2D

var preset_datablock_ref = preload("res://Scenes/drag_and_drop_card_game/preset_datablock.gd").new()

func _ready():
	await get_tree().process_frame  # Ensure all preset datablocks update first
	
	#print_preset_datablock_text("preset_datablocks")

##############################################################
### FUNCTION TO PRINT DATABLOCK POSITION AND TEXT LABELS    ##
##############################################################
func print_preset_datablock_text(group_name: String):
	var nodes = get_tree().get_nodes_in_group(group_name)
	for node in nodes:
		if node.has_node("preset_datablock_text"):  # Ensure label exists
			var text_label = node.get_node("preset_datablock_text")
			var clean_text = strip_bbcode_tags(text_label.text)  # Remove BBCode
			print(node.name, " \tPosition: ", node.position, "\t\tText: ", clean_text)
		else:
			print("No RichTextLabel found in ", node.name)


# cleans the text by removing tags and whitespace.
func strip_bbcode_tags(text: String) -> String:
	return text.replace("[center]", "").replace("[/center]", "")
