extends Node

var main_menu_scene: PackedScene = preload("res://scenes/UI/main_menu.tscn")
var pause_menu_scene: PackedScene = preload("res://scenes/UI/PauseMenu.tscn")  # путь с большой буквы

var current_menu: Control = null
var pause_menu_instance: Control = null

func show_main_menu():
	if current_menu:
		current_menu.queue_free()
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
	print("Пауза включена, меню создано")  # для отладки

func hide_pause_menu():
	if pause_menu_instance:
		pause_menu_instance.queue_free()
		pause_menu_instance = null
		get_tree().paused = false
		print("Пауза выключена")
