extends Node2D
class_name EstructuraSalida
@export var ruta: Resource
@export var ciudad_siguiente: Ciudad

var en_rango: bool = false
var mapa_abierto: bool = false
var mapa_scene = preload("res://menues/mapa.tscn")

func _input(event):
	if en_rango and not mapa_abierto and event.is_action_pressed("Interactuar"):
		_abrir_mapa()

func _abrir_mapa() -> void:
	mapa_abierto = true
	get_tree().paused = true
	var mapa = mapa_scene.instantiate()
	mapa.process_mode = Node.PROCESS_MODE_ALWAYS
	mapa.ruta_a_cargar = ruta
	mapa.ciudad_a_cargar = ciudad_siguiente
	get_tree().current_scene.add_child(mapa)
	mapa.cerrado.connect(_on_mapa_cerrado)

func _on_mapa_cerrado() -> void:
	mapa_abierto = false
	get_tree().paused = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		en_rango = true
		print("Presioná E para salir a la ruta")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		en_rango = false
