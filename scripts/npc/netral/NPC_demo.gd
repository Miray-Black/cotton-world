extends CharacterBody2D

@export var dialogue_text: String = "Привет, путник!"
@onready var interaction_area = $InteractionArea

var player_in_area: bool = false

func _on_interaction_area_entered(body):
	if body.is_in_group("player"):
		player_in_area = true

func _on_interaction_area_exited(body):
	if body.is_in_group("player"):
		player_in_area = false

func _input(event):
	if event.is_action_pressed("interact") and player_in_area:
		show_dialogue()

func show_dialogue():
	var dialog = AcceptDialog.new()
	dialog.dialog_text = dialogue_text
	dialog.title = "NPC"
	dialog.size = Vector2i(400, 200)
	add_child(dialog)
	dialog.popup_centered()
	# Ждём, пока диалог не закроется, и удаляем
	await dialog.popup_hide
	dialog.queue_free()
