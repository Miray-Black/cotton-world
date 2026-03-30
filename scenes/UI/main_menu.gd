extends Control

# Экспортируем путь к первому уровню, чтобы можно было менять в инспекторе
@export var first_level_path: String = "res://scenes/lvls/mane-test.tscn"

func _on_new_game_pressed():
	# Сброс глобальных переменных
	GameState.player_health = GameState.player_max_health
	GameState.enemies_killed = 0
	GameState.desires_count = 0
	GameState.inventory.clear()
	# ... и другие, если есть

	UIManager.hide_main_menu()
	get_tree().change_scene_to_file(first_level_path)

func _on_load_pressed():
	print("Load game - not implemented")

func _on_settings_pressed():
	print("Settings - not implemented")

func _on_exit_pressed():
	get_tree().quit()
