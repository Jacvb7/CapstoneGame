extends Node

signal enter_username

func action_enter_username() -> void:
	print("action_enter_username() called...")  # 🐞 Debug print
	enter_username.emit()

func _ready():
	pass
