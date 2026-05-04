extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	#if not anim_player.is_playing():
		#mover()
	pass

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
	print("Entre")
