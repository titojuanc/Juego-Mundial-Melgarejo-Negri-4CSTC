extends Node2D
class_name EstructuraGD

@export var pool: TiendaPool

@onready var tienda = $Tienda

var en_rango: bool = false

func _input(event):
	if en_rango and event.is_action_pressed("Interactuar"):
		if tienda.visible:
			tienda.cerrar()
		else:
			tienda.abrir(pool)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		en_rango = true
		print("Presioná E para entrar a la tienda")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		en_rango = false
