extends Node2D

@onready var area_2d: Area2D = $Area2D

func _ready():
	area_2d.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	print("bug scanner triggered by:", body.name)
	
	if body.name != "Player":
		return  # Ignore anything that isn't the player
	
	if body.name == "Player":  
		if GameDialogueManager.scanner_awaiter:
			GameDialogueManager.scanner_awaiter.resume()
			GameDialogueManager.scanner_awaiter = null
		queue_free()  # Makes the scanner disappear
