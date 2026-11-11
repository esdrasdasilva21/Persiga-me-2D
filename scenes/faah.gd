extends Node2D

@onready var santa = $Santa
@onready var monster = $Monster
@onready var goal_area = $GoalArea
@onready var message_label = $CanvasLayer/MessageLabel

var game_finished = false

func _ready():
	message_label.visible = false
	goal_area.body_entered.connect(_on_goal_reached)

func _on_goal_reached(body):
	if game_finished:
		return

	if body == santa:
		finish_game("VITÓRIA! CHEGASTE A LUANDA!")

	elif body == monster:
		finish_game("Você perdeu! O monstro vai aterrorizar Luanda.")

func finish_game(result):
	game_finished = true

	message_label.text = result
	message_label.visible = true

	santa.set_physics_process(false)
	monster.set_physics_process(false)
