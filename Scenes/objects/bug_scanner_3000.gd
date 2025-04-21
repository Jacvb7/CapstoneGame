extends Node2D

## Optional: connect this to resume dialogue
#signal scanner_animation_finished  

var tween : Tween
@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready():
	area_2d.body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	#print("bug scanner triggered by:", body.name)
	if body.name != "Player":
		return
	animate_scanner()
	GlobalVariables.has_scanner = true


# Animate scanner when player touches it
func animate_scanner() -> void:
	tween = create_tween()
	
	# raises the scanner upwards
	tween.tween_property(sprite_2d, "position:y", -60, 0.6)\
		.set_trans(Tween.TRANS_BOUNCE)\
		.set_ease(Tween.EASE_OUT)

	# scales the scanner to 150% it's normal size
	tween.parallel().tween_property(sprite_2d, "scale", Vector2(1.5, 1.5), 0.6)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)

	# Make the scanner wiggle
	for i in range(3):
		tween.tween_property(sprite_2d, "rotation_degrees", 15, 0.1)
		tween.tween_property(sprite_2d, "rotation_degrees", -15, 0.1)

	# shrink the scanner back to normal size
	tween.tween_property(sprite_2d, "rotation_degrees", 0, 0.1)
	tween.parallel().tween_property(sprite_2d, "scale", Vector2(1.0, 1.0), 0.4)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

	# remove scanner from the scene
	tween.tween_callback(Callable(self, "_on_scanner_animation_finished"))

func _on_scanner_animation_finished() -> void:
	queue_free()
	
	## Optional for Dialogue Manager
	#emit_signal("scanner_animation_finished")  
