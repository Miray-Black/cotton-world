extends CanvasLayer



func _on_resume_pressed():
	UIManager.hide_pause_menu()

func _on_main_menu_pressed():
	UIManager.hide_pause_menu()
	SceneManager.go_to_main_menu()
