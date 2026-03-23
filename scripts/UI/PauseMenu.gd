extends Control

func _ready():
	# Растягиваем на весь экран
	anchor_left = 0
	anchor_top = 0
	anchor_right = 1
	anchor_bottom = 1


func _on_resume_pressed():
	UIManager.hide_pause_menu()

func _on_main_menu_pressed():
	UIManager.hide_pause_menu()
