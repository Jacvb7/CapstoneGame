extends Node

var waiting_for_click = false

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
	DraggingEnabled.dragging_enabled = true  # Enables dragging when the tutorial is finished

var current_state = TutorialState.START

func _ready():
	print("Tutorial started.")
	transition_to(TutorialState.START)

func transition_to(new_state):
	current_state = new_state
	print("Transitioned to state:", new_state)

	match current_state:
		TutorialState.START:
			print("Start of tutorial. Disabling drag and drop.")
			wait_for_click(TutorialState.ROWS_HIGHLIGHT)

		TutorialState.ROWS_HIGHLIGHT:
			print("Highlight each row, one at a time.")
			
			for i in range(1, 7):
				print("Highlighting row ", i, ".\n")
				await highlight_row(i)
			
			print("All rows highlighted. Moving to next tutorial step.")
			wait_for_click(TutorialState.EXAMPLE_HIGHLIGHT)

		TutorialState.EXAMPLE_HIGHLIGHT:
			print("Highlight example row.")
			await highlight_row(1)
			wait_for_click(TutorialState.COLUMN_0_HIGHLIGHT)

		TutorialState.COLUMN_0_HIGHLIGHT:
			print("Highlighting name column 0.")
			await highlight_column(0)
			wait_for_click(TutorialState.COLUMN_1_HIGHLIGHT)

		TutorialState.COLUMN_1_HIGHLIGHT:
			print("Highlighting total legs column 1.")
			await highlight_column(1)
			wait_for_click(TutorialState.COLUMN_2_HIGHLIGHT)

		TutorialState.COLUMN_2_HIGHLIGHT:
			print("Highlighting color column 2.")
			await highlight_column(2)
			wait_for_click(TutorialState.DONE)

		TutorialState.DONE:
			print("Tutorial finished. Enabling drag and drop.")
			on_tutorial_finished()

# Function to wait for a click before transitioning
func wait_for_click(next_state):
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
