extends Node2D

var encuentro = preload("res://scenes/Encuentro.tscn")
var evento = preload("res://eventos/alaska/rueda_pinchada.tres")
@onready var auto:CharacterBody2D = $Auto
@onready var fondo:Control = $Ruta_1
@onready var inventario:CanvasLayer = $"Inventario"
@onready var hotbar:CanvasLayer = $"Hotbar"
var instancia_encuentro = null 
var en_movimiento= true

func _ready() -> void:
	auto.mover_ruedas()
	auto.mover()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		if en_movimiento:
			fondo.parar() 
			en_movimiento=false
			instancia_encuentro = encuentro.instantiate()
			add_child(instancia_encuentro)
			instancia_encuentro._iniciar(auto)
			instancia_encuentro.configurar_peligros(evento)
			inventario.bloquear_por_evento()
		else:
			fondo.reanudar()
			auto.mover()
			instancia_encuentro.terminar()
			en_movimiento=true
			inventario.cerrar_forzado()
		
