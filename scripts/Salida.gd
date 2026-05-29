extends Node2D
class_name EstructuraSalida
@export var ruta: Resource
@export var ciudad_siguiente: Ciudad

var en_rango: bool = false

func _input(event):
	if en_rango and event.is_action_pressed("Interactuar"):
		GameManager.ruta_actual = ruta
		GameManager.ciudad_siguiente = ciudad_siguiente
		get_tree().change_scene_to_file("res://scenes/ruta_gameplay.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		en_rango = true
		print("Presioná E para salir a la ruta")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		en_rango = false
