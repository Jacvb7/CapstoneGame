extends Node2D

@onready var state_machine = $tutorial_state_machine # Reference to the state machine node

func _ready() -> void:
	if state_machine:
		print("State machine found. Starting tutorial.")
		state_machine.transition_to(state_machine.TutorialState.START)
	else:
		print("Error: State machine not found!")

func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			DisplayServer.window_set_size(Vector2i(1280, 720))
