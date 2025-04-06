extends BaseGameDialogueBalloon

func _process(_delta):
	visible = not get_tree().paused
