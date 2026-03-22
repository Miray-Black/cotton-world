extends Node

# Инвентарь (список строк с названиями желаний)
var inventory: Array = []
var desires_count: int = 0

# Статистика
var enemies_killed: int = 0

# Здоровье игрока (храним глобально, чтобы синхронизировать между сценами)
var player_health: int = 3
var player_max_health: int = 3
var invulnerable: bool = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):  # по умолчанию Esc
		if not UIManager.pause_menu_instance:
			UIManager.show_pause_menu()
		else:
			UIManager.hide_pause_menu()
