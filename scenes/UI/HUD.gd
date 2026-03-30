extends CanvasLayer

@onready var health_label = $MarginContainer/VBoxContainer/HealthLabel
@onready var kills_label = $MarginContainer/VBoxContainer/KillsLabel
@onready var desires_label = $MarginContainer/VBoxContainer/DesiresLabel

func _ready():
	# Подписываемся на события
	GameEvents.desire_collected.connect(_on_desire_collected)
	GameEvents.enemy_killed.connect(_on_enemy_killed)
	GameEvents.player_took_damage.connect(_on_player_took_damage)
	
	# Первоначальное обновление
	_update_health()
	_update_kills()
	_update_desires()
	
	add_to_group("hud")

func _on_desire_collected(_desire_name):
	_update_desires()

func _on_enemy_killed():
	_update_kills()

func _on_player_took_damage(_current_health):
	_update_health()

func _update_health():
	health_label.text = "HP: %d/%d" % [GameState.player_health, GameState.player_max_health]

func _update_kills():
	kills_label.text = "Kills: %d" % GameState.enemies_killed

func _update_desires():
	desires_label.text = "Desires: %d" % GameState.desires_count

func show_hud():
	show()

func hide_hud():
	hide()
