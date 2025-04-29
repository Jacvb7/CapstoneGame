# drag_drop_main.gd
extends Node2D

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Disable processing if the minigame is not ready and the player doesn't have the scanner
	if !GlobalVariables.minigame_ready and !GlobalVariables.has_scanner:
		set_process(false)

# Called every frame
func _process(_delta: float) -> void:
	# Re-enable processing (useful if conditions change at runtime)
	set_process(true)
	# Check if player presses the table key to exit
	on_table_pressed()

# Handles logic when the player presses the "table" key
func on_table_pressed() -> void: 
	# If the minigame is started but not yet finished
	if Input.is_action_just_pressed("table") and !GlobalVariables.disable_T and GlobalVariables.minigame_ready and !GlobalVariables.finish_mini_game:
		# Return the player to Level 1 scene
		get_tree().change_scene_to_file("res://Levels/Level 1/Level 1.tscn")
		
	# If the minigame is finished
	if Input.is_action_just_pressed("table") and GlobalVariables.finish_mini_game:
		get_tree().change_scene_to_file("res://Levels/Level 1/Level 1.tscn")
		# After returning, disable further table input to avoid unwanted re-triggers
		if GlobalVariables.finish_mini_game:
			GlobalVariables.disable_T = true
