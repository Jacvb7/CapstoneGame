# bug_database.gd
# Description: Level 1 database for datablocks.

var preset_bug_data = {
	"FIELDS": ["NAME", "TOTAL LEGS", "COLOR"],
	"EXAMPLE_BUG": ["ALBY", "6", "Yellow"] # "res://Scenes/drag_and_drop_card_game/bug_images/yellow_beetle.png"
}


var bug_data = {
	"BIX": { "legs": 4, "color": "Blue" }, 
	"EMBER": { "legs": 8, "color": "Purple" }, 
	"FIZZGIG": { "legs": 0, "color": "Orange" }, 
	"NOX": { "legs": 6, "color": "Red" }, 
	"TAFFY": { "legs": 4, "color": "Green" } 
}


# retrieve key values from the bug_data dictionary.
func get_bug_names():
	return bug_data.keys()


# Validate datablocks placed into slots in datablock_mang.gd by key value (name) 
# and field value (column 1 = total legs and column 2 = color of bug).
func validate_bug_data(bug_name, col, value):
	if bug_name in bug_data:
		if col == 1:
			return str(bug_data[bug_name]["legs"]) == value
		elif col == 2:
			return bug_data[bug_name]["color"] == value
	return false


func total_blocks_being_placed():
	var count = 0
	if bug_data.is_empty():
		return 0  # Handle case where database is empty
	for bug in bug_data.keys():  # Iterate over bug names
		count += bug_data[bug].size()  # Add the number of features for each bug
	return count
