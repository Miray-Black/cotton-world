extends Control

func _ready():
	$VBoxContainer/ResumeButton.pressed.connect(_on_resume_pressed)
	$VBoxContainer/MainMenuButton.pressed.connect(_on_main_menu_pressed)

func _on_resume_pressed():
	UIManager.hide_pause_menu()

func _on_main_menu_pressed():
	UIManager.hide_pause_menu()
	# Возвращаемся в главное меню (удаляем текущую сцену)
	get_tree().change_scene_to_file("res://scenes/Bootstrap.tscn")  # или просто загрузить пустую сцену
	# Главное меню появится через Bootstrap
