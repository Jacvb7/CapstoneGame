extends Control



@onready var state_label: Label = $HBoxContainer/State_label
@onready var check_button: CheckButton = $HBoxContainer/CheckButton



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_button.toggled.connect(_on_check_button_toggled)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_label_text(button_pressed : bool) -> void:
	if button_pressed != true:
		state_label.text = "Off"
	else:
		state_label.text = "On"


func _on_check_button_toggled(toggled_on: bool) -> void:
	set_label_text(toggled_on)
