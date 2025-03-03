class_name OptionsMenu #create its own class
extends Control

@onready var exit_button: Button = $MarginContainer/VBoxContainer/Exit_button

#create a signal because this will not be able to go back entirely to the main menu and set everything correctly
#by itself
signal exit_options_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#connecting the exit button on button down to the function _on_exit_button_button_down
	exit_button.button_down.connect(_on_exit_button_button_down)
	#To avoid an error where the button is still clickable even when the options menu is gone
	set_process(false)	#This code will not run at all unless the process is running or set to true.
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_exit_button_button_down() -> void:
	exit_options_menu.emit() #emit the signal
	set_process(false)
	
	



#To be added into main_menu script:
	#in func on_exit_options_menu():
		#margin_container.visible = true
		#options_menu.visible = false
		
	#in func _on_settings_button_down():
		#options_menu.set_process(true)
		#(add this between the two lines of code alredady in the function
		
