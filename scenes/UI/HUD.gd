extends CanvasLayer

@onready var health_label = $MarginContainer/VBoxContainer/HealthLabel
@onready var kills_label = $MarginContainer/VBoxContainer/KillsLabel
@onready var desires_label = $MarginContainer/VBoxContainer/DesiresLabel

func _ready():
	update_all()
	# Добавляем HUD в группу для удобного поиска
	add_to_group("hud")

func update_all():
	update_health()
	update_kills()
	update_desires()

func update_health():
	health_label.text = "HP: %d/%d" % [GameState.player_health, GameState.player_max_health]

func update_kills():
	kills_label.text = "Kills: %d" % GameState.enemies_killed

func update_desires():
	desires_label.text = "Desires: %d" % GameState.desires_count

func show_hud():
	show()

func hide_hud():
	hide()
