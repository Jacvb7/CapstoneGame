extends Node

signal enter_username

func action_enter_username() -> void:
	enter_username.emit()
