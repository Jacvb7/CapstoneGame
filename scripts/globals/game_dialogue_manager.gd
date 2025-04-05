extends Node

# custom object you can await on, and resume from anywhere else.
class SignalAwaiter:
	signal resumed

	func resume():
		resumed.emit()

	func _to_signal():
		return resumed

signal enter_username
signal wait_for_scanner_started(awaiter)

var scanner_awaiter = null

func action_enter_username() -> void:
	enter_username.emit()

# Creates an object that pauses the dialogue, emits it in a signal (wait_for_scanner_started), 
# and will let something else resume it later.
func action_wait_for_scanner(dialogue_line: DialogueLine, game_states: Array):
	print("WAITING for scanner to be found...")  # 🐞 Debug print
	
	var awaiter = SignalAwaiter.new()
	wait_for_scanner_started.emit(awaiter)
	return awaiter


func _ready():
	DialogueManager.connect("wait_for_scanner_started", Callable(self, "_on_wait_for_scanner_started"))


func _on_wait_for_scanner_started(awaiter):
	scanner_awaiter = awaiter
