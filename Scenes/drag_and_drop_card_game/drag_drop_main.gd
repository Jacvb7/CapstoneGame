# drag_drop_main.gd

extends Node2D

# References to other nodes
@onready var datablock_manager = $datablock_mang
@onready var unplaced_datablocks = $unplaced_datablocks
@onready var preset_manager = $preset_datablock_manager

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create the preset datablock manager if it doesn't exist yet
	if not preset_manager:
		print("Creating preset_datablock_manager")
		var preset_manager_scene = Node2D.new()
		preset_manager_scene.name = "preset_datablock_manager"
		preset_manager_scene.script = load("res://scripts/preset_datablockmang.gd")
		add_child(preset_manager_scene)
		preset_manager = preset_manager_scene


# Check for changes in datablock positions to trigger validation
func _process(delta):
	# Only call this every few frames to optimize performance
	if Engine.get_frames_drawn() % 10 == 0:  # Check every 10 frames
		if preset_manager:
			preset_manager.update_validation()


func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720)) 


#func _on_button_pressed() -> void:
#	get_tree().change_scene_to_file("res://Scenes/mainmenu/main_menu.tscn")
