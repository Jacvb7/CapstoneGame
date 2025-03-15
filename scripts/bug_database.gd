# bug_database.gd

var preset_bug_data = {
	"FIELDS": ["NAME", "TOTAL LEGS", "COLOR"],
	"EXAMPLE_BUG": ["FIZZGIG", "8", "Orange"]
}

var bug_data = {
	"ALBY": { "legs": 6, "color": "Red" },
	"BIX": { "legs": 8, "color": "Blue" },
	"EMBER": { "legs": 6, "color": "Yellow" },
	"NOX": { "legs": 4, "color": "Green" },
	"TAFFY": { "legs": 6, "color": "Purple" }
}


func get_bug_names():
	return bug_data.keys()


## Added validation function to check if a datablock has correct data for a bug
#func validate_bug_data(bug_name, attribute_type, value):
	#if bug_name in bug_data:
		#if attribute_type == "legs":
			#return str(bug_data[bug_name]["legs"]) == value
		#elif attribute_type == "color":
			#return bug_data[bug_name]["color"] == value
	#return false
