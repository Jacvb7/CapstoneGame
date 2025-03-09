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
