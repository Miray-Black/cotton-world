extends Node

# Путь к главному меню
const MAIN_MENU_PATH = "res://scenes/ui/main_menu.tscn"
# Путь к первому уровню
const FIRST_LEVEL_PATH = "res://scenes/lvls/lvl_1.tscn"

# Загружает сцену по пути с возможностью показа экрана загрузки
func load_scene(path: String, use_loading_screen: bool = false):
	if use_loading_screen:
		# TODO: показать экран загрузки
		pass
	# Меняем сцену
	get_tree().change_scene_to_file(path)
	# Ждём один кадр, чтобы сцена загрузилась
	await get_tree().process_frame
	# Добавляем HUD
	var hud_scene = load("res://scenes/ui/hud.tscn")
	var hud = hud_scene.instantiate()
	get_tree().current_scene.add_child(hud)

func _update_hud_visibility():
	var current = get_tree().current_scene
	if current.is_in_group("lvls"): 
		HUD.show_hud()
	else:
		HUD.hide_hud()

# Вернуться в главное меню
func go_to_main_menu():
	# Сбрасываем всё, чтобы при новом старте было чисто
	Global.inventory.clear()
	Global.desires_count = 0
	Global.enemies_killed = 0
	Global.player_health = Global.player_max_health
	load_scene(MAIN_MENU_PATH)

# Начать новую игру (сбросить глобальные данные и загрузить первый уровень)
func start_new_game():
	# Сброс глобальных данных
	Global.inventory.clear()
	Global.desires_count = 0
	Global.enemies_killed = 0
	Global.player_health = Global.player_max_health
	# Загружаем первый уровень
	load_scene(FIRST_LEVEL_PATH)

# Продолжить игру (загрузить сохранённый уровень)
func continue_game():
	# Загрузить уровень из сохранения (пока заглушка)
	var saved_level = Global.get_saved_level()  # нужно реализовать
	load_scene(saved_level)
