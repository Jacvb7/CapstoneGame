extends Node2D
#class_name GameManager

#signal toggle_game_paused(is_paused : bool)

@onready var pause_menu: Control = $CanvasLayer/Pause_Menu

func _process(delta: float) -> void:
	on_esc_pressed()

func on_esc_pressed() -> void:
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
		
func pause():
	print("paused from game")
	pause_menu.set_process(true)
	#get_tree().paused = true


#Past section as of 3/7/25
#var game_paused : bool = false:
	#get: 
		#return game_paused
	#set(value):
		#game_paused = value
		#get_tree().paused = game_paused
		#emit_signal("toggle_game_paused", game_paused)

#func _input(event : InputEvent): 
	#if(event.is_action_pressed("esc")):
		#game_paused = !game_paused


#func _on_toggle_game_paused(is_paused: bool) -> void:
	#pass # Replace with function body.
