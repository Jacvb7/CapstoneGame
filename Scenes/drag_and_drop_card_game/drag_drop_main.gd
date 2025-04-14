#drag_drop_main.gd
extends Node2D

signal tut_finished

@onready var exit: Button = $VBoxContainer2/exit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#pass
	set_process(true)
	on_table_pressed()
	
func on_table_pressed() -> void: 
	if Input.is_action_just_pressed("table") and GlobalVariables.disable_T == false and GlobalVariables.minigame_ready == true and GlobalVariables.finish_mini_game == false:
		get_tree().change_scene_to_file("res://Levels/Level 1/Level 1.tscn")
		
	if Input.is_action_just_pressed("table") and GlobalVariables.finish_mini_game == true:
		get_tree().change_scene_to_file("res://Levels/Level 1/Level 1.tscn")
		if GlobalVariables.finish_mini_game == true:
			GlobalVariables.disable_T = true
				
	# Used to make sure that the "t" button press isn't disabled until the game is completed
	#else:
	#	get_tree().change_scene_to_file("res://Levels/Level 1/Level 1.tscn")
	
#func _on_resolutions_item_selected(index: int) -> void:
	#match index:
		#0:
			#DisplayServer.window_set_size(Vector2i(1920,1080))
		#1:
			#DisplayServer.window_set_size(Vector2i(1600,900))
		#2:
			#DisplayServer.window_set_size(Vector2i(1280,720)) 


#func _on_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/mainmenu/main_menu.tscn")
