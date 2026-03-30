extends Node
class_name AttackComponent

@onready var attack_area = owner.get_node("AttackArea")
@onready var sprite = owner.get_node("AnimatedSprite2D")

var facing_direction: int = 1

func _ready():
	attack_area.area_entered.connect(_on_attack_area_entered)
	attack_area.monitoring = false

func _input(event):
	if event.is_action_pressed("attack"):  # отдельное действие!
		perform_attack()

func perform_attack():
	# Обновляем направление по спрайту
	facing_direction = -1 if sprite.flip_h else 1
	attack_area.position.x = abs(attack_area.position.x) * facing_direction
	attack_area.monitoring = true
	await get_tree().create_timer(0.1).timeout
	attack_area.monitoring = false

func _on_attack_area_entered(area):
	if area.is_in_group("enemy_hurtbox"):
		var enemy = area.get_parent()
		if enemy.has_method("take_damage"):
			enemy.take_damage(1)
