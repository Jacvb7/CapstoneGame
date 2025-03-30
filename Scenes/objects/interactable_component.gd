class_name InteractableComponent
extends Area2D

signal interactable_activated
signal interactable_deactivated

func _ready() -> void:
	#print("in interactable")
	pass


func _on_body_entered(body: Node2D) -> void:
	#print("entered")
	interactable_activated.emit()


func _on_body_exited(body: Node2D) -> void:
	#print("exited")
	interactable_deactivated.emit()
