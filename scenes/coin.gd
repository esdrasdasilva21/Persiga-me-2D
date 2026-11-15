
extends Area2D

signal coin_collected(amount: int)

@onready var coin_sprite: Sprite2D = $Sprite2D

var collected: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:

	if collected:
		return

	if body.is_in_group("player"):
		collected = true
		monitoring = false

		# Comunicar a recolha
		coin_collected.emit(1)

		# Animar o desaparecimento
		var tween = create_tween()
		tween.set_parallel(true)

		tween.tween_property(
			coin_sprite,
			"scale",
			Vector2.ZERO,
			0.18
		)

		tween.tween_property(
			coin_sprite,
			"modulate:a",
			0.0,
			0.18
		)

		await tween.finished

		queue_free()
