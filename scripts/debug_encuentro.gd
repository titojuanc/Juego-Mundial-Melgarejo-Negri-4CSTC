extends Node2D

var encuentro = preload("res://scenes/Encuentro.tscn")
@onready var auto:CharacterBody2D = $Auto
@onready var fondo:Control = $Ruta_1

var en_movimiento= true

func _ready() -> void:
	auto.mover()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		var instancia_encuentro = encuentro.instantiate()
		if en_movimiento:
			fondo.parar() 
			en_movimiento=false
		else:
			fondo.reanudar()
			auto.mover()
			instancia_encuentro.terminar()
			en_movimiento=true
		instancia_encuentro._iniciar(auto)
		add_child(instancia_encuentro)
