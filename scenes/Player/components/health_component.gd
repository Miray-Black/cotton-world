extends Node
class_name HealthComponent

signal died

@export var max_health: int = 3

var current_health: int

func _ready():
	current_health = max_health

func take_damage(amount: int):
	current_health -= amount
	# Для игрока – специальный сигнал, для врага – отдельно
	if owner.is_in_group("player"):
		GameEvents.player_took_damage.emit(current_health)
	if current_health <= 0:
		died.emit()
