extends Control

# UI node references for displaying and adjusting audio volume
@onready var audio_name_lbl: Label = $HBoxContainer/Audio_name_lbl
@onready var h_slider: HSlider = $HBoxContainer/HSlider
@onready var audio_num_lbl: Label = $HBoxContainer/Audio_num_lbl

# Exported dropdown (enum) to select which audio bus this slider controls
@export_enum("Master", "Music", "Sfx") var bus_name : String

# Index of the audio bus in the AudioServer
var bus_index : int = 0

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Connect the slider’s value_changed signal to its handler
	h_slider.value_changed.connect(_on_h_slider_value_changed)
	# Get the index of the selected bus from the AudioServer
	get_bus_name_by_index()
	# Set the label to show which bus this slider controls
	set_name_label_text()
	# Initialize the slider’s value based on the current volume of the bus
	set_slider_value()
	
# Called when the slider value is changed by the user
func _on_h_slider_value_changed(value: float) -> void:
	# Convert slider value (0–1) to decibels and update the bus volume
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	# Update the numeric label next to the slider
	set_audio_num_label_text()

# Updates the numeric label next to the slider to show volume percentage
func set_audio_num_label_text() -> void:
	audio_num_lbl.text = str(h_slider.value * 100) + "%"  # h_slider.value is between 0 and 1

# Retrieves the index of the selected bus from the AudioServer
func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)

# Updates the text label that describes which bus is being adjusted
func set_name_label_text() -> void:
	audio_name_lbl.text = str(bus_name) + " Volume"

# Sets the slider value based on the current volume of the audio bus
func set_slider_value() -> void:
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_audio_num_label_text()
