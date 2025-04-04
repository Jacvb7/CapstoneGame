#drag_drop_main.gd
extends Node2D

# Jacob is adding variables and functions to be used for debugging
@onready var pause_menu: Control = $CanvasLayer/Pause_Menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#pass
	on_table_pressed()
	on_esc_pressed()
	
func on_esc_pressed() -> void:
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
		
func pause():
	print("paused from game")
	pause_menu.set_process(true)
	get_tree().paused = true
	
func on_table_pressed() -> void: 
	if Input.is_action_just_pressed("table"):
		get_tree().change_scene_to_file("res://Levels/Level 1/Level 1.tscn")

func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720)) 


#func _on_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/mainmenu/main_menu.tscn")
