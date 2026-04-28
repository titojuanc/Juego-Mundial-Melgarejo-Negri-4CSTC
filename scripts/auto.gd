extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	position = Vector2.ZERO

func mover_arriba():
	position.y += 20

func mover_abajo():
	position.y -=20
	
func mover_medio():
	position.y = 0
