extends CharacterBody2D

@export var health: int = 1
@export var speed: float = 5.0  # нормальная скорость
@export var damage: int = 1

var player: Node2D = null

func _ready():
	# Ищем игрока один раз (если он есть в сцене)
	player = get_tree().get_first_node_in_group("player")
	
	# Подключаем сигналы
	$Hurtbox.area_entered.connect(_on_hurtbox_area_entered)
	$Hitbox.body_entered.connect(_on_hitbox_body_entered)

func _physics_process(_delta):
	if player == null:
		return  # если игрок умер или не найден
	
	# Простейшее движение к игроку
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func _on_hurtbox_area_entered(area: Area2D):
	if area.is_in_group("player_attack"):
		take_damage(1)

func take_damage(amount: int):
	health -= amount
	print("Enemy health: ", health)
	if health <= 0:
		die()

func die():
	Global.enemies_killed += 1
	var hud = get_tree().get_first_node_in_group("hud")
	if hud:
		hud.update_kills()
	queue_free()

func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage)
