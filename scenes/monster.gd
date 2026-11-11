extends CharacterBody2D

@export var speed: float = 320.0
@export var jump_velocity: float = -650.0
@export var obstacle_check_distance: float = 25.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var gravity: float = ProjectSettings.get_setting(
    "physics/2d/default_gravity"
)


func _physics_process(delta):

	# Aplicar gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	# Movimento contínuo para a direita
	velocity.x = speed

	# Verificar obstáculos quando estiver no chão
	if is_on_floor():

		var collision = test_move(
			global_transform,
			Vector2(obstacle_check_distance, 0)
		)

		# Saltar ao encontrar um obstáculo
		if collision:
			velocity.y = jump_velocity
			print("Obstáculo encontrado! Monstro a saltar.")

	# Movimentar o monstro
	move_and_slide()
