extends Node

# Предзагружаем сцены
var main_menu_scene: PackedScene = preload("res://scenes/ui/main_menu.tscn")
var pause_menu_scene: PackedScene = preload("res://scenes/ui/PauseMenu.tscn")  # создадим позже

# Текущие экземпляры меню
var current_menu: Control = null
var pause_menu_instance: Control = null

func show_main_menu():
	# Если уже открыто какое-то меню, закрываем его
	if current_menu:
		current_menu.queue_free()
	# Создаём главное меню
	var menu_instance = main_menu_scene.instantiate()
	get_tree().root.add_child(menu_instance)
	current_menu = menu_instance

func hide_main_menu():
	if current_menu:
		current_menu.queue_free()
		current_menu = null

func show_pause_menu():
	if pause_menu_instance:
		return
	pause_menu_instance = pause_menu_scene.instantiate()
	get_tree().root.add_child(pause_menu_instance)
	get_tree().paused = true

func hide_pause_menu():
	if pause_menu_instance:
		pause_menu_instance.queue_free()
		pause_menu_instance = null
		get_tree().paused = false
