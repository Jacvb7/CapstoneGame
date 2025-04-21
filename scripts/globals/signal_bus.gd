extends Node

signal show_byte
signal hide_byte
signal hide_npc_byte
signal show_objectives
signal hide_objectives

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _show_byte() -> void:
	show_byte.emit()
	
func _hide_byte() -> void:
	hide_byte.emit()
	
func _hide_npc_byte() -> void:
	hide_npc_byte.emit()

func _show_objectives() -> void:
	show_objectives.emit()
	
func _hide_objectives() -> void:
	hide_objectives.emit()
	
func open_user_manual() -> void:
	OS.shell_open("https://docs.google.com/document/d/1JglxoCD9LgmA5xCS-_VFxYuatIop8Nm1U663883mTa4/edit?usp=sharing")
