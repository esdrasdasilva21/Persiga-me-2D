extends CharacterBody2D

# Referência ao AnimatedSprite2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Configurações de movimento
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 5

# Gravidade do projeto
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Contador de saltos
var jump_count = 0


func _ready():
	print("Santa Script Inicializado")


func _physics_process(delta):

	# TESTE 1: Verificar execução do script
	print("Physics Process ativo")

	# TESTE 2: Verificar leitura dos comandos
	var direction = Input.get_axis("move_left", "move_right")
	print("Direção recebida: ", direction)

	# Aplicar gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jump_count = 0

	# Movimento horizontal
	if direction != 0:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Sistema Double Jump
	if Input.is_action_just_pressed("jump"):
		print("Comando de salto recebido!")

		if jump_count < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			jump_count += 1
			print("Salto executado: ", jump_count)

	# TESTE 3: Verificar velocidade
	print("Velocidade horizontal: ", velocity.x)

	# Movimentação e colisões
	move_and_slide()

	# Sistema de animações
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("Fall")

	elif direction != 0:
		animated_sprite.play("Run")

	else:
		animated_sprite.play("Idle")
