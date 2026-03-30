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
