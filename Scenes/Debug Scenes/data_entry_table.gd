extends Control

@onready var button: Button = $Button
@onready var drag_drop_test: Node2D = $DragDropTest

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("in data_entry_table")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	



func _on_button_pressed() -> void:
	button.visible = false
	drag_drop_test.visible = false
