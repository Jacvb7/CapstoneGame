# https://youtu.be/8cV-5ByZLOE?si=wFFo8gPB-pFAIRat

extends TextureRect

# triggers when you click and drag
func _get_drag_data(at_position):
	
	# allows you to see the object being dragged
	var preview_texture = TextureRect.new()
	# properties for visualizing the dragging of an object
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(90, 90)
	
	# create a control node set to preview the texture being dragged
	var preview = Control.new()
	preview.add_child(preview_texture)
	set_drag_preview(preview)
	texture = null
	
	# return texture for dragging
	return preview_texture.texture
	
# triggers when you hover with dragged item
func _can_drop_data(_pos, data):
	# check whether the dragged item is droppable or not
	return data is Texture2D
	
# triggers when you drop the dragged item
func _drop_data(_pos, data):
	# assign the dragged texture from _get_drag_data()
	texture = data
	
