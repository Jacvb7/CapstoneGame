extends Node2D


@onready var pause_menu: pauseMenu = $CanvasLayer/Pause_Menu



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	escape_key()
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#escape_key()
	pass

func escape_key():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause_menu.visible = true
		pause_menu.pause_game()
		

	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		pause_menu.resume_game()
