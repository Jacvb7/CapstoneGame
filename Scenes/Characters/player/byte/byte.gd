extends Player

@export var parent : Player
@export var animated_sprite_2d: AnimatedSprite2D

var speed = 40

@onready var follow_point = parent.get_node("Sprite2D/FollowPoint")
	
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
