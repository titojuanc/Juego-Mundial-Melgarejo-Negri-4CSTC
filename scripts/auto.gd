extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var anim_player = $AnimationPlayer

@export var velocidad = 1000

var si = true
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction = Input.get_action_strength("mover_der") - Input.get_action_strength("mover_izq")
	
	velocity.x = direction * velocidad
	
	move_and_slide()
	
	if direction != 0:
		mover()
	else:
		parar_anim_player()
	
func mover_arriba():
	sprite.position.y += 5

func mover_abajo():
	sprite.position.y -= 5
	
func mover_medio():
	sprite.position.y = 0

func mover():
	anim_player.play("andar")
	
func parar_anim_player():
	anim_player.play("parar")
	
func mover_ruedas():
	sprite.play("idle")
	
func parar_ruedas():
	sprite.stop()
