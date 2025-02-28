# Godot 4 Drag-and-Drop Tutorial: Create Interactive Games with Ease
# https://youtu.be/uhgswVkYp0o?si=EnqCVx_lHVnKuDgp

extends StaticBody2D

func _ready():
	modulate = Color(Color.ORANGE_RED, 0.7)

func _process(delta):
	# should be able to see script: res://global.gd
	if global.is_dragging:
		visible = true
	else:
		visible = false
