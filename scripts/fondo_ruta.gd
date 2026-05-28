extends Control

@onready var fondo_animado: Parallax2D = $Parallax2D

func parar():
	var anim = create_tween()
	anim.tween_property(fondo_animado, "autoscroll", Vector2.ZERO, 2.0)

func reanudar():
	var anim = create_tween()
	anim.tween_property(fondo_animado, "autoscroll", Vector2(-600, 0), 2.0)
