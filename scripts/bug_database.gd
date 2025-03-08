# bug_database.gd

var preset_bug_data = {
	"FIELDS": ["NAME", "TOTAL LEGS", "COLOR"],
	"FIZZGIG": { "legs": 8, "color": "Orange" }
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


# Added validation function to check if a datablock has correct data for a bug
func validate_bug_data(bug_name, attribute_type, value):
	if bug_name in bug_data:
		if attribute_type == "legs":
			return str(bug_data[bug_name]["legs"]) == value
		elif attribute_type == "color":
			return bug_data[bug_name]["color"] == value
	return false


# Return the list of field names to display in the table
func get_preset_field_names():
	# Return the fields array
	return preset_bug_data["FIELDS"]


# Get a specific field value from the preset_bug_data dictionary
func get_preset_bug_data(bug_name, field_index):
	if bug_name == "FIELDS":
		# For the header row, return the field name
		return preset_bug_data["FIELDS"][field_index]
	elif bug_name == "FIZZGIG":
		# For FIZZGIG, return the attribute value based on the field index
		if field_index == 0:
			return "FIZZGIG"  # Name
		elif field_index == 1:
			return str(preset_bug_data["FIZZGIG"]["legs"])  # Legs
		elif field_index == 2:
			return preset_bug_data["FIZZGIG"]["color"]  # Color
	return ""


# Get data for a specific bug and attribute
func get_bug_data(bug_name, attribute_type):
	if bug_name in bug_data and attribute_type in bug_data[bug_name]:
		return str(bug_data[bug_name][attribute_type])
	return ""
