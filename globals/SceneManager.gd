extends Node

# Путь к главному меню
const MAIN_MENU_PATH = "res://scenes/ui/main_menu.tscn"
# Путь к первому уровню
const FIRST_LEVEL_PATH = "res://scenes/lvls/lvl_1.tscn"

# Загружает сцену по пути с возможностью показа экрана загрузки
func load_scene(path: String, use_loading_screen: bool = false):
	if use_loading_screen:
		pass
	get_tree().change_scene_to_file(path)
	await get_tree().process_frame
	# Добавляем HUD только если загружаем уровень (не главное меню)
	if path != MAIN_MENU_PATH:
		var hud_scene = load("res://scenes/ui/hud.tscn")
		var hud = hud_scene.instantiate()
		get_tree().current_scene.add_child(hud)

func go_to_main_menu():
	Global.inventory.clear()
	Global.desires_count = 0
	Global.enemies_killed = 0
	Global.player_health = Global.player_max_health
	load_scene(MAIN_MENU_PATH)

func start_new_game():
	Global.inventory.clear()
	Global.desires_count = 0
	Global.enemies_killed = 0
	Global.player_health = Global.player_max_health
	load_scene(FIRST_LEVEL_PATH)

func continue_game():
	var saved_level = Global.get_saved_level()  # нужно реализовать
	load_scene(saved_level)
