extends Node2D

var balloon_scene = preload("res://dialogue/game_dialogue_balloon.tscn")

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent

var in_range: bool

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_dectivated)
	interactable_component.hide()
	
	#GameDialogueManager.action_enter_username.connect(on_enter_username)
	
func on_interactable_activated() -> void:
	interactable_label_component.show()
	in_range = true
	
	
func on_interactable_dectivated() -> void:
	interactable_label_component.hide()
	in_range = false

func _unhandled_input(event: InputEvent) -> void:
	if in_range:	
		if event.is_action_pressed("Interact"):
			var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate()
			get_tree().current_scene.add_child(balloon)
			balloon.start(load("res://dialogue/conversations/NPCTest.dialogue"), "start")
			

func on_enter_username() -> void:
	pass
