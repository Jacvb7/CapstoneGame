extends Node

var waiting_for_click = false
const SPEED_FOR_ALL_ROWS = 0.3
const SPEED_FOR_ONE_ROW_OR_COLUMN = 0.75

# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
var dialogue_label  # Reference to the dialogue label

# boolean so state machine only runs once
var flag = true

enum TutorialState { 
	START, 
	ROWS_HIGHLIGHT, 
	EXAMPLE_HIGHLIGHT, 
	COLUMN_0_HIGHLIGHT, 
	COLUMN_1_HIGHLIGHT, 
	COLUMN_2_HIGHLIGHT, 
	DONE }

# Re-enable dragging when the tutorial is complete
func on_tutorial_finished():
	GlobalVariables.dragging_enabled = true  # Enables dragging when the tutorial is finished
	
	# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
	update_dialogue("BTYE: Click on the variable NAME of each bug to examine them and complete the data!")

var current_state = TutorialState.START

func _ready():
	print("Tutorial started.")
	
	# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
	dialogue_label = $"../RichTextLabel"  # Adjust the path
	
	# MOVED FROM _PROCESS() TO _READY() 4/16
	if GlobalVariables.enable_click and flag:
		flag = false
		transition_to(TutorialState.START)

# MOVED THIS LOGIC FROM _PROCESS() TO _READY() 4/16
#func _process(delta: float) -> void:
	#if GlobalVariables.enable_click and flag:
		#flag = false
		#transition_to(TutorialState.START)
		

func transition_to(new_state):
	current_state = new_state
	#print("Transitioned to state:", new_state)

	match current_state:
		TutorialState.START:
			#print("Start of tutorial. Disabling drag and drop.")
			# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
			update_dialogue("Byte: I’ll walk you through how the archive is organized so you can fill in the missing data on these bugs!")
			await get_tree().create_timer(3).timeout  # Wait 3 seconds
			update_dialogue("Byte: Click the mouse to continue.")
			wait_for_click(TutorialState.ROWS_HIGHLIGHT)

		TutorialState.ROWS_HIGHLIGHT:
			#print("Highlight each row, one at a time.")
			# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
			update_dialogue("Byte: In the archive, each row represents a record of a bug living in Evergrove!")
			
			for i in range(1, 7):
				#print("Highlighting row ", i, ".\n")
				await highlight_row(i, SPEED_FOR_ALL_ROWS)
			
			#print("All rows highlighted. Moving to next tutorial step.")
			wait_for_click(TutorialState.EXAMPLE_HIGHLIGHT)

		TutorialState.EXAMPLE_HIGHLIGHT:
			#print("Highlight example row.")
			# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
			update_dialogue("Byte: And look! The record for ALBY is already complete! Click on Alby to take a closer look!")
			
			await highlight_row(1, SPEED_FOR_ONE_ROW_OR_COLUMN)
			wait_for_click(TutorialState.COLUMN_0_HIGHLIGHT)

		TutorialState.COLUMN_0_HIGHLIGHT:
			#print("Highlighting name column 0.")
			# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
			update_dialogue("Byte: The first column variable is NAME. Notice how each bug’s name is listed in this column?")
			
			await get_tree().create_timer(1).timeout  # Wait 1 seconds
			await highlight_column(0, SPEED_FOR_ONE_ROW_OR_COLUMN)
			wait_for_click(TutorialState.COLUMN_1_HIGHLIGHT)

		TutorialState.COLUMN_1_HIGHLIGHT:
			#print("Highlighting total legs column 1.")
			# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
			update_dialogue("Byte: The next variable is TOTAL LEGS. If you count ALBY’s legs, there should be 6 in total!")
			
			await get_tree().create_timer(1).timeout  # Wait 1 seconds
			await highlight_column(1, SPEED_FOR_ONE_ROW_OR_COLUMN)
			wait_for_click(TutorialState.COLUMN_2_HIGHLIGHT)

		TutorialState.COLUMN_2_HIGHLIGHT:
			#print("Highlighting color column 2.")
			# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
			update_dialogue("Byte: The last variable is COLOR. ALBY is mostly YELLOW, so the value in her record is also YELLOW!")
			
			await get_tree().create_timer(1).timeout  # Wait 1 seconds
			await highlight_column(2, SPEED_FOR_ONE_ROW_OR_COLUMN)
			wait_for_click(TutorialState.DONE)

		TutorialState.DONE:
			#print("Tutorial finished. Enabling drag and drop.")
			# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
			update_dialogue("Byte: That’s all you need to know to get started!")
			await get_tree().create_timer(2).timeout  # Wait 3 seconds
			on_tutorial_finished()


# Function to wait for a click before transitioning
func wait_for_click(_next_state):
	#print("click: ", GlobalVariables.enable_click)
	if GlobalVariables.enable_click:
		waiting_for_click = true
		await get_tree().process_frame  # Ensure the event system has time to process

func _input(event):
	if waiting_for_click and event is InputEventMouseButton and event.pressed:
		waiting_for_click = false
		transition_to(current_state + 1)  # Move to the next state


func highlight_row(row: int, duration: float = 0.75):
	var tween = get_tree().create_tween()
	tween.set_parallel(true)  # Run all animations in parallel
	var nodes_to_highlight = []
	
	if row == 0 or row == 1:
		# all nodes are present in global group: "preset_datablocks"
		# Find all nodes in the specified row
		for node in get_tree().get_nodes_in_group("preset_datablocks"):
			if node.name.to_lower().contains("r" + str(row)):  # Check if node belongs to the correct row
				nodes_to_highlight.append(node)
	# first node in global group: "preset_datablocks" and 
	# all remaining nodes in global group: "datablock_slots"
	else:
		# Find nodes in the current row
		for node in get_tree().get_nodes_in_group("datablock_slots") + get_tree().get_nodes_in_group("preset_datablocks"):
			if node.name.to_lower().contains("r" + str(row)):  # Check if node is in this row
				nodes_to_highlight.append(node)
	
	## FOR DEBUGGING
	#print("Highlighting row", row, "nodes:", nodes_to_highlight)
	#if nodes_to_highlight.is_empty():
		#print("No nodes found for row", row)
		#return

	# Apply highlight to all nodes in parallel
	for node in nodes_to_highlight:
		tween.tween_property(node, "modulate", Color(1, 1, 0, 1), duration)  # Yellow

	await tween.finished  # Wait for all animations to complete

	# Reset color for all nodes in parallel
	tween = get_tree().create_tween()  # Create a new tween for resetting color
	tween.set_parallel(true)  # Ensure parallel execution
	for node in nodes_to_highlight:
		tween.tween_property(node, "modulate", Color(1, 1, 1, 1), duration)  # Reset to normal

	await tween.finished  # Wait for reset animation to complete


func highlight_column(column: int, duration: float = 0.75):
	var tween = get_tree().create_tween()
	tween.set_parallel(true)  # Run all animations in parallel
	var nodes_to_highlight = []
	
	# all nodes are present in global group: "preset_datablocks"
	if column == 0:
		for node in get_tree().get_nodes_in_group("preset_datablocks"):
			if node.name.to_lower().contains("c" + str(column)):  # Check if node belongs to the correct row
				nodes_to_highlight.append(node)
	# the first 2 nodes are in global group: "preset_datablocks" and 
	# all remaining nodes in global group: "datablock_slots"
	else:
		# Find nodes in the current column
		for node in get_tree().get_nodes_in_group("datablock_slots") + get_tree().get_nodes_in_group("preset_datablocks"):
			if node.name.to_lower().contains("c" + str(column)):  # Check if node is in this column
				nodes_to_highlight.append(node)
		
	## FOR DEBUGGING
	#print("Highlighting column", column, "nodes:", nodes_to_highlight)
	#if nodes_to_highlight.is_empty():
		#print("No nodes found for column", column)
		#return

	# Apply highlight to all nodes in parallel
	for node in nodes_to_highlight:
		tween.tween_property(node, "modulate", Color(1, 1, 0, 1), duration)  # Yellow

	await tween.finished  # Wait for all animations to complete

	# Reset color for all nodes in parallel
	tween = get_tree().create_tween()  # Create a new tween for resetting color
	tween.set_parallel(true)  # Ensure parallel execution
	for node in nodes_to_highlight:
		tween.tween_property(node, "modulate", Color(1, 1, 1, 1), duration)  # Reset to normal

	await tween.finished  # Wait for reset animation to complete


# TEMPORARY WAY TO DISPLAY TEXT IN THE SCENE FOR THE TUTORIAL
func update_dialogue(text: String):
	if dialogue_label:
		dialogue_label.text = text
		dialogue_label.modulate = Color.BLACK
	else:
		print("Dialogue label not found!")
