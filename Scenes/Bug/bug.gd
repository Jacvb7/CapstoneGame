extends Node2D  # Change to CharacterBody2D if using physics

class_name Bug  # Allows other scripts to reference Bug easily

# Properties shared by all bugs
@export var species: String = "Unknown"
@export var size: float = 1.0
@export var color: Color = Color.WHITE
@export var speed: float = 100.0  # Movement speed

# Called when the node enters the scene tree for the first time
func _ready():
	print("Bug spawned: " + species)

# Movement function (only if bugs move)
func move(direction: Vector2, delta: float):
	position += direction * speed * delta

# Placeholder function for bug behavior (to be overridden)
func interact():
	print(species + " reacts to the player.")
