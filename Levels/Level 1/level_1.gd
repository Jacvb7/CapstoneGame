extends Node2D
#class_name GameManager

#signal toggle_game_paused(is_paused : bool)

#@onready var pause_menu: Control = $CanvasLayer/Pause_Menu
#@onready var pause_menu: Control = $Pause_Menu
#@onready var pause_menu: Control = $CanvasLayer/Pause_Menu
@onready var interactable_component: InteractableComponent = $InteractableComponent
#@onready var drag_drop_test: Node2D = $CanvasLayer2/DragDropTest
@onready var pause_menu: Control = $CanvasLayer/Pause_Menu
@onready var drag_drop_test: Node2D = $CanvasLayer2/DragDropTest2

func _process(delta: float) -> void:
	on_esc_pressed()
	on_table_pressed()

func on_esc_pressed() -> void:
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
		
func on_table_pressed() -> void: 
	if Input.is_action_just_pressed("table"):
		get_tree().change_scene_to_file("res://Scenes/drag_and_drop_card_game/drag_drop_main.tscn")

func pause():
	print("paused from game")
	pause_menu.set_process(true)
	get_tree().paused = true

func _ready() -> void:
	interactable_component.interactable_activated.connect(interacting)
	pass


func interacting() -> void:
	drag_drop_test.visible = true
	
	EnableVariables.enable_click = true
	print("click: ", EnableVariables.enable_click)
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
