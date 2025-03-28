class_name  Player
extends CharacterBody2D

#@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
#@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"

var player_direction: Vector2
#@onready var interacting_component: Node2D = $InteractingComponent


#func _process(delta: float) -> void:
	#_on_E_pressed()

func _ready():
	#add_to_group("player")
	print("in player")
	#interacting_component.
	pass
	
#func _on_E_pressed() -> void:
	#
	#if Input.is_action_just_pressed("Interact") and can_interact:
		#print("in E pressed")
		##print("in _input")
		##print("current interactions: ")
		##print(current_interactions)
		##if current_interactions:
			##can_interact = false			
			##await current_interactions[0].interact.call()
			##interact()
			##can_interact = true
		#can_interact = false			
		##await current_interactions[0].interact.call()
		#interact()
		#can_interact = true
#
#func interact() -> void:
	#print("interacting")
	#data_entry_table.visible = true
	##button.visible = true
	#interact_label.visible = true

	

#func _on_area_2d_body_entered(body: NonPlayableCharacter) -> void:
	#if body.is_in_group("npc"):  # Ensure the NPC has this group
		##canvas_layer.visible = true
		#print("proximity")
#
#
#func _on_area_2d_body_exited(body: NonPlayableCharacter) -> void:
	#if body.is_in_group("npc"):  # Ensure the NPC has this group
		#canvas_layer.visible = false
