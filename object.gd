extends Sprite2D

var dragging_2 = false # similar var declared in global.gd
var offset_2 = Vector2(0,0)
# step size to create table
var snap = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging_2:
		var newPostision = get_global_mouse_position() - offset_2
		position = Vector2(snapped(newPostision.x, snap), snapped(newPostision.y, snap))


func _on_button_button_down():
	dragging_2 = true
	offset_2 = get_global_mouse_position() - global_position


func _on_button_button_up():
	dragging_2 = false
