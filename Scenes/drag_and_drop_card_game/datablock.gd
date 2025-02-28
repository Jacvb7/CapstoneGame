# https://youtu.be/1mM73u1tvpU?si=z1QizoPoQK9xzoC2
# script to attatch signals to the datablock_mang

extends Node2D

signal hovered
signal hovered_off

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# when a new data block is created this calls parent of the child node.
	# The parent should be datablock_mang and a fatal error will be thrown if
	# a datablock is not the child of this parent
	get_parent().connect_datablock_signals(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	# print("hovered")
	emit_signal("hovered", self)


func _on_area_2d_mouse_exited() -> void:
	# print("hovered off")
	emit_signal("hovered_off", self)
