extends CanvasLayer

@onready var health_label = $MarginContainer/VBoxContainer/HealthLabel
@onready var kills_label = $MarginContainer/VBoxContainer/KillsLabel
@onready var desires_label = $MarginContainer/VBoxContainer/DesiresLabel



func _ready():
		# Добавляем HUD в группу для удобного поиска
	GameEvents.desire_collected.connect(_on_desire_collected)
	GameEvents.enemy_killed.connect(_on_enemy_killed)
	GameEvents.player_took_damage.connect(_on_player_took_damage)

func update_kills():
	kills_label.text = "Kills: %d" % GameState.enemies_killed

func update_desires():
	desires_label.text = "Desires: %d" % GameState.desires_count

func show_hud():
	show()

func hide_hud():
	hide()

func _on_desire_collected(_name):
	update_desires()

func _on_enemy_killed(_name):
	update_kills()

func _on_player_took_damage(_name):
	update_desires()
