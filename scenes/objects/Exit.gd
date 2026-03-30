extends Area2D

@export var next_level_path: String = "res://mane-test.tscn"
@export var required_kills: int = 1  # сколько врагов нужно убить

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player") and GameState.enemies_killed >= required_kills:
		get_tree().change_scene_to_file(next_level_path)
	else:
		print("Not enough kills: ", GameState.enemies_killed, "/", required_kills)
