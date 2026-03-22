extends Control

# Экспортируем путь к первому уровню, чтобы можно было менять в инспекторе
@export var first_level_path: String = "res://mane-test.tscn"

func _on_new_game_pressed():
	# Скрываем главное меню через UIManager (пока не создан, но создадим)
	UIManager.hide_main_menu()
	# Загружаем первый уровень
	get_tree().change_scene_to_file(first_level_path)

func _on_load_pressed():
	print("Load game - not implemented")

func _on_settings_pressed():
	print("Settings - not implemented")

func _on_exit_pressed():
	get_tree().quit()
