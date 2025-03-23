class_name  Player
extends CharacterBody2D

#@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
#@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"

var player_direction: Vector2


func _ready():
	#add_to_group("player")
	pass


#func _on_area_2d_body_entered(body: NonPlayableCharacter) -> void:
	#if body.is_in_group("npc"):  # Ensure the NPC has this group
		#canvas_layer.visible = true
		#print("proximity")
#
#
#func _on_area_2d_body_exited(body: NonPlayableCharacter) -> void:
	#if body.is_in_group("npc"):  # Ensure the NPC has this group
		#canvas_layer.visible = false
