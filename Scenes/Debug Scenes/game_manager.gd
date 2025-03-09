extends Node2D

#On ready variable declarations
@onready var canvas_layer: CanvasLayer = $GameTileMap/CanvasLayer			#The layer that has the pause menu
@onready var pause_menu: Control = $GameTileMap/CanvasLayer/Pause_Menu		#The pause menu scene


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Keep checking if esc ss pressed througout the game process
	on_esc_pressed()
	

func on_esc_pressed() -> void:
	#If esc is pressed and the game is not paused, then pause it.
	if Input.is_action_just_pressed("esc") and !get_tree().paused: 
		pause()
	
	
func pause():
	#Pausing the game
	pause_menu.set_process(true)	#Run pause_menu.gd - the script for the pause scene
	#get_tree().paused = true		#Pause game state
	canvas_layer.visible = true		#Show pause screen
	
