extends Control
#@onready var drag_drop_main: Node2D = $DragDropMain


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#drag_drop_main.set_process(false)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	visible = false
	var mini_game = preload("res://Scenes/drag_and_drop_card_game/drag_drop_main.tscn").instantiate()
	#var mini_game = preload("res://Scenes/drag_and_drop_card_game/drag_drop_main.tsc).instantiate()
	$CanvasLayer.add_child(mini_game)
	EnableVariables.enable_click = true
