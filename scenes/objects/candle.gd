extends Area2D
@export var desire_name: String = "wish_01"  # Идентификатор желания/предмета

var player_in_area: bool = false  # Флаг: игрок рядом?


func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true
		print("Player is here")
		# Можно показать подсказку "Нажми E", но пока не обязательно

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false
		print("Player is not here")
		# Скрыть подсказку

func _input(event):
	# Проверяем, что игрок рядом и нажата кнопка взаимодействия
	if player_in_area and event.is_action_pressed("interact"):
		pick_up()

func pick_up():
	GameState.inventory.append(desire_name)
	GameState.desires_count += 1
	print("Подобрана свеча: ", desire_name)
	GameEvents.desire_collected.emit(desire_name)
	# Блокируем повторный ввод
	set_process_input(false)
	# Создаём анимацию исчезновения
	var new_candle = load("res://scenes/objects/candle.tscn").instantiate()
	new_candle.global_position = global_position
	get_parent().add_child(new_candle)
	queue_free()
	var tween = create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate:a", 0.0, 0.1)  # Прозрачность
	tween.tween_callback(queue_free)  # После анимации удалить
	# Также можно добавить звук	

	# Удаляем объект (пока без анимации)
