extends Node2D

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_dectivated)
	interactable_component.hide()
	
func on_interactable_activated() -> void:
	interactable_label_component.show()
	
func on_interactable_dectivated() -> void:
	interactable_label_component.hide()
