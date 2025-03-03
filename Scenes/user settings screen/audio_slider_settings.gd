extends Control



@onready var audio_name_lbl: Label = $HBoxContainer/Audio_name_lbl
@onready var h_slider: HSlider = $HBoxContainer/HSlider
@onready var audio_num_lbl: Label = $HBoxContainer/Audio_num_lbl

#name of the audio busses we need to set up
@export_enum("Master", "Music", "Sfx") var bus_name : String

var bus_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	h_slider.value_changed.connect(_on_h_slider_value_changed)
	get_bus_name_by_index()
	set_name_label_text()
	set_slider_value()

func set_name_label_text() -> void:
	audio_name_lbl.text = str(bus_name) + " Volume"
	
func set_audio_num_label_text() -> void:
	audio_num_lbl.text = str(h_slider.value * 100) + "%"	#* 100 because h_slider.value is a value between 0 and 1

func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name) #AudioServer is the server in control of the busses. This is where the busses are contained


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_slider_value() -> void:
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_audio_num_label_text()

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value)) #linear_to_db changes linear energy to decibels
	set_audio_num_label_text()
