extends Node2D
#class_name GameManager

#signal toggle_game_paused(is_paused : bool)

#@onready var pause_menu: Control = $CanvasLayer/Pause_Menu
#@onready var pause_menu: Control = $Pause_Menu
#@onready var pause_menu: Control = $CanvasLayer/Pause_Menu
@onready var interactable_component: InteractableComponent = $InteractableComponent
#@onready var drag_drop_test: Node2D = $CanvasLayer2/DragDropTest
@onready var pause_menu: Control = $CanvasLayer/Pause_Menu
#@onready var drag_drop_test: Node2D = $CanvasLayer2/DragDropTest2
#var mini_game = preload("res://Scenes/drag_and_drop_card_game/drag_drop_main.tscn")
@onready var button: Button = $Player/Camera2D2/Button
var mini_game: Node = null  # <- Store a reference to the instance
@onready var drag_drop_main: Node2D = $GameOverlayRoot/DragDropMain



func _process(delta: float) -> void:
	on_esc_pressed()
	on_table_pressed()

func on_esc_pressed() -> void:
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
		
func on_table_pressed() -> void: 
	if Input.is_action_just_pressed("table") and GlobalVariables.has_scanner and not GlobalVariables.finish_mini_game:
		get_tree().change_scene_to_file("res://Scenes/drag_and_drop_card_game/drag_drop_main.tscn")
		GlobalVariables.enable_click = true
		
func pause():
	print("paused from game")
	pause_menu.set_process(true)
	get_tree().paused = true

func _ready() -> void:
	interactable_component.interactable_activated.connect(interacting)
	interactable_component.interactable_deactivated.connect(deactivating)
	pass

#
func deactivating() -> void:
	GlobalVariables.minigame_ready = false
	print(GlobalVariables.minigame_ready)
	#button.visible = false
	#if mini_game:
		#mini_game.queue_free()
		#mini_game = null  # Clear the reference
	#GlobalVariables.enable_click = false
	#$Player/Camera2D2.enabled = true
	#$Player/Camera2D2.make_current()

func interacting() -> void:
	GlobalVariables.minigame_ready = true
	print(GlobalVariables.minigame_ready)
	#button.visible = true
	#drag_drop_test.visible = true
	#var mini_game = preload("res://Scenes/drag_and_drop_card_game/drag_drop_main.tscn").instantiate()
	##var mini_game = preload("res://Scenes/drag_and_drop_card_game/drag_drop_main.tsc).instantiate()
	#$CanvasLayer2.add_child(mini_game)
	#GlobalVariables.enable_click = true change from 4/10
	#print("click: ", EnableVariables.enable_click)
	#get_tree().paused = true
	
	
func _on_button_pressed() -> void:
	#drag_drop_main.visible = true
	if mini_game == null:
		mini_game = preload("res://Scenes/Debug Scenes/data_table.tscn").instantiate()
		#$CanvasLayer2/GameOverlayRoot.add_child(mini_game)
		$GameOverlayRoot.add_child(mini_game)
		$Player/Camera2D2.enabled = false 
		#get_tree().paused = true
		#drag_drop_main.visible = true
		mini_game.z_index = 10
		GlobalVariables.enable_click = true
		#get_tree().paused = true
		
		#mini_game.pause_mode = Node.PauseModeEnum.PROCESS  # this keeps drag/drop working while world is paused
		#mini_game.set("pause_mode", 2)
		#print(mini_game)
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
