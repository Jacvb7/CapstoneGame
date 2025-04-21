# Handles the opening of the minigame on 'T' press
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Disable this script if the minigame hasn't been triggered or the scanner hasn't been collected
	if !GlobalVariables.minigame_ready and !GlobalVariables.has_scanner:
		set_process(false)

	# Also disable if the minigame has already been completed
	if GlobalVariables.finish_mini_game:
		set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Only allow interaction if the T key is not disabled
	if (!GlobalVariables.disable_T):
		on_table_pressed()
	
# Handles the action when the "table" key is pressed after the minigame is complete
func on_table_pressed() -> void: 
	if Input.is_action_just_pressed("table") and GlobalVariables.finish_mini_game:
		get_tree().change_scene_to_file("res://Levels/Level 1/Level 1.tscn")	# Change back to Level 1 scene
		GlobalVariables.disable_T = true		# Prevent further triggering of the table minigame
		GlobalVariables.dragging_enabled = false	# Disable dragging so interaction is stopped
		set_process(false)	# Stop this script's processing since it has done its job
