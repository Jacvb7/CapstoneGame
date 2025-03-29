extends Node

enum TutorialState { 
	START, 
	ROW_HIGHLIGHT, 
	EXAMPLE_HIGHLIGHT, 
	COLUMN_0_HIGHLIGHT, 
	COLUMN_1_HIGHLIGHT, 
	COLUMN_2_HIGHLIGHT, 
	DONE 
	}

var tutorial_state = TutorialState.START
var tutorial_active = true  # Prevents player input during tutorial


func _ready():
	set_process_input(false)  # Disable input at the start
	start_tutorial()


func highlight_row(row: Control):
	var tween = get_tree().create_tween()
	tween.tween_property(row, "modulate", Color(1, 1, 1, 1), 0.5)  # Highlight
	tween.tween_interval(0.5)
	tween.tween_property(row, "modulate", Color(1, 1, 1, 0.5), 0.5)  # Dim
	
	await tween.finished
	
	
func _input(event):
	if event.is_action_pressed("click") and not tutorial_active:
		pass
		# advance_dialogue()


var dialogue_active = false

func show_dialogue(text: String):
	dialogue_active = true
	$DialogueText.text = text
	
	# Wait for the player to click before continuing
	await get_tree().create_timer(0.5).timeout  # Prevent skipping too fast
	await wait_for_click()
	
	dialogue_active = false

func wait_for_click():
	await get_tree().create_timer(0.1).timeout  # Short delay to prevent instant skipping
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("click"):
			break


func start_tutorial():
	set_process_input(false)  # Disable gameplay input
	
	await show_dialogue("Each row represents a different insect.")
	for row in get_tree().get_nodes_in_group("table_rows"):
		await highlight_row(row)
		
	await show_dialogue("This is an example row with complete data.")
	await highlight_row($ExampleRow)
	
	await show_dialogue("Now, let’s look at the columns...")
	for column in get_tree().get_nodes_in_group("table_columns"):
		pass
		#await highlight_column(column)
		
	await show_dialogue("Now it's your turn!")
	
	set_process_input(true)  # Enable gameplay input
