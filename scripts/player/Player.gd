extends CharacterBody2D

@export var speed : float = 300.0
@export var gravity : float = 1200.0
@export var jump_velocity : float = -400.0

@onready var attack_area = $AttackArea
@onready var sprite = $AnimatedSprite2D  # или AnimatedSprite2D

var can_jump : bool = true
var facing_direction : int = 1  # 1 - вправо, -1 - влево

func _ready():
	# Подключаем сигнал области атаки
	attack_area.area_entered.connect(_on_attack_area_entered)
	# Изначально выключаем мониторинг атаки
	attack_area.monitoring = false


func _physics_process(delta):
	# Гравитация
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Горизонтальное движение
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		facing_direction = sign(direction)
		sprite.flip_h = (facing_direction == -1)  # разворачиваем спрайт
	velocity.x = direction * speed
	
	# Приседание (замедление)
	if Input.is_action_pressed("crouch"):
		velocity.x *= 0.5
	
	# Прыжок
	if can_jump and Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	move_and_slide()
	
	# Простая анимация (заглушка)
	update_animation(direction)

func update_animation(_direction: float):
	# Здесь можно ставить анимации, но пока пропустим
	pass

func _input(event):
	# Атака по нажатию клавиши (например, F)
	if event.is_action_pressed("interact"):
		perform_attack()
	if event.is_action_pressed("pause - ?? - ??"):  # по умолчанию Esc
		if not UIManager.pause_menu_instance:
			UIManager.show_pause_menu()
		else:
			print("попытка снять паузу")
			UIManager.hide_pause_menu()

func perform_attack():
	# Размещаем область атаки перед игроком
	# Предположим, что AttackArea изначально расположена справа от центра игрока
	attack_area.position.x = abs(attack_area.position.x) * facing_direction
	attack_area.monitoring = true
	# Через короткое время выключаем
	await get_tree().create_timer(0.1).timeout
	attack_area.monitoring = false

func _on_attack_area_entered(area: Area2D):
	# Если область атаки пересеклась с hurtbox врага
	if area.is_in_group("enemy_hurtbox"):
		# Предполагаем, что у врага есть метод take_damage в родителе
		var enemy = area.get_parent()
		if enemy.has_method("take_damage"):
			enemy.take_damage(1)

func take_damage(amount: int):
	if Global.invulnerable:
		return
	Global.player_health -= amount
	print("Player health: ", Global.player_health)
	# Находим HUD и обновляем
	var hud = get_tree().get_first_node_in_group("hud")
	if hud:
		hud.update_health()
	if Global.player_health <= 0:
		die()

func die():
	print("Player died")
	# Здесь можно перезапустить уровень или показать экран смерти
	get_tree().reload_current_scene()  # временно
