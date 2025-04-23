extends Player

@export var parent : Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var is_byte_visable: bool = GlobalVariables.isByteVisable
@onready var byte: CharacterBody2D = $"."
@onready var find_bug_scanner_objective: Control = $"../CanvasLayer2/FindBugScannerObjective"
@onready var use_bug_scanner_objective: Control = $"../CanvasLayer2/UseBugScannerObjective"



var speed = 40

@onready var follow_point = parent.get_node("Sprite2D/FollowPoint")

func _ready():
	SignalBus.show_byte.connect(_show_byte)
	SignalBus.hide_byte.connect(_hide_byte)
	SignalBus.show_objectives.connect(_show_objectives)
	SignalBus.hide_objectives.connect(_hide_objectives)
	byte.hide()
	find_bug_scanner_objective.hide()
	use_bug_scanner_objective.hide()

func _show_byte():
	byte.show()

func _hide_byte():
	byte.hide()
	
func _show_objectives():
	find_bug_scanner_objective.show()
	
func _hide_objectives():
	find_bug_scanner_objective.hide()
	use_bug_scanner_objective.show()
	
func _physics_process(delta):
	var target = follow_point.global_position
	velocity = Vector2.ZERO
	if position.distance_to(target) > 20:
		velocity = position.direction_to(target) * speed
		
	if velocity.length() > 0:
		animated_sprite_2d.play("fly")
	else:
		animated_sprite_2d.play("idle")
		
	move_and_slide()	
