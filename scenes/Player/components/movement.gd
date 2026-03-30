extends Node
class_name MovementComponent

@export var speed: float = 300.0
@export var gravity: float = 1200.0
@export var jump_velocity: float = -400.0

var can_jump: bool = true

func _physics_process(delta):
	var parent = owner as CharacterBody2D
	if not parent:
		return
	
	# Гравитация
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta
	
	# Ввод
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		parent.sprite.flip_h = (direction == -1)  # предполагаем, что у parent есть sprite
	parent.velocity.x = direction * speed
	
	# Приседание (замедление)
	if Input.is_action_pressed("crouch"):
		parent.velocity.x *= 0.5
	
	# Прыжок
	if can_jump and Input.is_action_just_pressed("jump") and parent.is_on_floor():
		parent.velocity.y = jump_velocity
	
	parent.move_and_slide()
