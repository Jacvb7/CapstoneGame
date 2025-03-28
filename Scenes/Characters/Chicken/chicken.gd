extends NonPlayableCharacter

@onready var interactable: Area2D = $Interactable

func _ready() -> void:
	walk_cycles = randi_range(min_walk_cycle, max_walk_cycle)
	#interactable.interact = _on_interact
	print("in chicken")
	
func _on_interact():
	#logic for table visibility.
	
	print("interacting")
	
