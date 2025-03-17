# bug_database.gd

var preset_bug_data = {
	"FIELDS": ["NAME", "TOTAL LEGS", "COLOR"],
	"EXAMPLE_BUG": ["ALBY", "6", "Yellow"] # "res://Scenes/drag_and_drop_card_game/bug_images/yellow_beetle.png"
}

var bug_data = {
	"BIX": { "legs": 4, "color": "Blue" }, # "res://Scenes/drag_and_drop_card_game/bug_images/blue_butterfly.png"
	"EMBER": { "legs": 8, "color": "Purple" }, # "res://Scenes/drag_and_drop_card_game/bug_images/purple_spider.png"
	"FIZZGIG": { "legs": 0, "color": "Orange" }, # "res://Scenes/drag_and_drop_card_game/bug_images/orange_snail.png"
	"NOX": { "legs": 6, "color": "Red" }, # "res://Scenes/drag_and_drop_card_game/bug_images/red_ant.png"
	"TAFFY": { "legs": 4, "color": "Green" } # "res://Scenes/drag_and_drop_card_game/bug_images/green_acanthocephala.png"
}


func get_bug_names():
	return bug_data.keys()


# Added validation function to check if a datablock has correct data for a bug
func validate_bug_data(bug_name, col, value):
	if bug_name in bug_data:
		if col == 1:
			return str(bug_data[bug_name]["legs"]) == value
		elif col == 2:
			return bug_data[bug_name]["color"] == value
	return false
