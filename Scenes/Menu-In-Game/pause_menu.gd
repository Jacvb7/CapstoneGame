extends Control

# Process from 3/7/25
#@export var game_manager : GameManager

#On ready variable declarations
@onready var options_menu: OptionsMenu = $Options_Menu			#The options menu scene
@onready var resume: Button = $VBoxContainer/resume				#Resume button
@onready var settings: Button = $VBoxContainer/settings			#Settings button

#These are used for hiding pause menu visibility
@onready var texture_rect: PanelContainer = $TextureRect
@onready var v_box_container: VBoxContainer = $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.visible = false
	v_box_container.visible = false
	set_process(false)												#I set it to false so that this script does not run immediatly. 
																	#It is set to true in game_manager.gd
	options_menu.exit_options_menu.connect(on_exit_options_menu)	#Connection to options menu's exit button
	#resume.button_down.connect(_on_resume_pressed)					#connection to resume button
	#settings.button_down.connect(_on_settings_button_down)
	# Process from 3/7/25
	#hide()
	#game_manager.connect("toggle_game_paused", _on_game_manager_toggle_game_paused)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#When process is set to true, will run these functions
	pause()				#Pauses game state and makes pause menu visible
	on_esc_pressed()	#To resume game when esc is pressed
	#pass
	

func on_exit_options_menu() -> void:
	#Visibility when exiting settings screen
	v_box_container.visible = true
	options_menu.visible = false

func _on_settings_button_down() -> void:
	#Visibiltiy for settings screen
	print("in settings")
	texture_rect.visible = false
	v_box_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true


func pause():
	#When game is paused
	print("paused from pause screen")
	get_tree().paused = true			#Pause the game state
	
	v_box_container.visible = true		#Make the pause menu visible
	texture_rect.visible = true
	

func on_esc_pressed() -> void:
	#When esc is pressed from pause menu
	#If esc is pressed and the game is in pause state(which it should be, but I added the condition just in case and to avoid any problems later on)
	if Input.is_action_just_pressed("esc") and get_tree().paused:	
		_on_resume_pressed()	#Resumes game 

func _on_resume_pressed() -> void:
	#Resumes game
	set_process(false)		#Sets this process to false, so that it does not run when the game is resumed
	get_tree().paused = false			#resumes game state
	v_box_container.visible = false		#Hides pause screen
	texture_rect.visible = false

#Jacob changed this, instead of quiting out the game we will include the option to return to the main menu
func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainmenu/main_menu.tscn")

func _on_exit_game_pressed() -> void: 
	get_tree().quit()

# Process from 3/7/25
#func _on_game_manager_toggle_game_paused(is_paused : bool):
	#if(is_paused):
		#show()
	#else: 
		#hide()

# Process from 3/7/25
#func _on_resume_pressed():
	#game_manager.game_paused = false

	
	
	
