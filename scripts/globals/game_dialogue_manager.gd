extends Node

signal enter_username

func action_enter_username() -> void:
	enter_username.emit()
	
func give_player_bug_scanner():
	pass
