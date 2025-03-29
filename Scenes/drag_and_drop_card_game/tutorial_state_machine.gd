extends Node

var waiting_for_click = false

enum TutorialState { 
	START, 
	ROW_HIGHLIGHT, 
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
			wait_for_click(TutorialState.ROW_HIGHLIGHT)

		TutorialState.ROW_HIGHLIGHT:
			print("Highlighting row.")
			wait_for_click(TutorialState.EXAMPLE_HIGHLIGHT)

		TutorialState.EXAMPLE_HIGHLIGHT:
			print("Highlighting example.")
			wait_for_click(TutorialState.COLUMN_0_HIGHLIGHT)

		TutorialState.COLUMN_0_HIGHLIGHT:
			print("Highlighting column 0.")
			wait_for_click(TutorialState.COLUMN_1_HIGHLIGHT)

		TutorialState.COLUMN_1_HIGHLIGHT:
			print("Highlighting column 1.")
			wait_for_click(TutorialState.COLUMN_2_HIGHLIGHT)

		TutorialState.COLUMN_2_HIGHLIGHT:
			print("Highlighting column 2.")
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
