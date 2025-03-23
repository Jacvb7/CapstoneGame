extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_camera_limits():
	var map_limits = $"../../GameTileMap".get_used_rect()
	var map_cellsize = $"../../GameTileMap".cell_size
	$".".limit_left = map_limits.position.x * map_cellsize.x
	$".".limit_right = map_limits.end.x * map_cellsize.x
	$".".limit_top = map_limits.position.y * map_cellsize.y
	$".".limit_bottom = map_limits.end.y * map_cellsize.y
