# preset_datablock_mang.gd

extends Node2D

var preset_datablock_ref = preload("res://Scenes/drag_and_drop_card_game/preset_datablock.gd").new()


func _ready():
	await get_tree().process_frame  # Ensure all preset datablocks update first
	
	print_preset_datablock_text("preset_datablocks")


#############################################################
## FUNCTION TO PRINT DATABLOCK POSITION AND TEXT LABELS    ##
#############################################################
#preset_datablock_r0c0 	Position: (381, 56)		Text: NAME
#preset_datablock_r0c1 	Position: (445, 56)		Text: TOTAL LEGS
#preset_datablock_r0c2 	Position: (508, 56)		Text: COLOR
#preset_datablock_r1c0 	Position: (381, 88)		Text: FIZZGIG
#preset_datablock_r1c1 	Position: (445, 88)		Text: 8
#preset_datablock_r1c2 	Position: (509, 88)		Text: Orange
#preset_datablock_r2c0 	Position: (381, 120)		Text: ALBY
#preset_datablock_r3c0 	Position: (381, 152)		Text: BIX
#preset_datablock_r4c0 	Position: (381, 184)		Text: EMBER
#preset_datablock_r5c0 	Position: (381, 216)		Text: NOX
#preset_datablock_r6c0 	Position: (381, 248)		Text: TAFFY
func print_preset_datablock_text(group_name: String):
	var nodes = get_tree().get_nodes_in_group(group_name)
	for node in nodes:
		if node.has_node("preset_datablock_text"):  # Ensure label exists
			var text_label = node.get_node("preset_datablock_text")
			var clean_text = strip_bbcode_tags(text_label.text)  # Remove BBCode
			print(node.name, " \tPosition: ", node.position, "\t\tText: ", clean_text)
		else:
			print("No RichTextLabel found in ", node.name)


func strip_bbcode_tags(text: String) -> String:
	return text.replace("[center]", "").replace("[/center]", "")
