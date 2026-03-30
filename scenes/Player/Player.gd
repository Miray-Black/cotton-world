extends CharacterBody2D

@onready var movement = $MovementComponent
@onready var attack = $AttackComponent
@onready var health = $HealthComponent

func _ready():
	health.died.connect(_on_death)
	# возможно, подключить сигналы атаки к визуалу

func _on_death():
	GameEvents.player_died.emit()
