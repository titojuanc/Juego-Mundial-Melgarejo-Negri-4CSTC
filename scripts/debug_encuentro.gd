extends Node2D

var encuentro = preload("res://scenes/Encuentro.tscn")
var evento = preload("res://eventos/alaska/estres.tres")
var item_card_scene = preload("res://scenes/item_card.tscn")
@onready var auto:CharacterBody2D = $Auto
@onready var fondo:Control = $Ruta_1
@onready var inventario:CanvasLayer = $"Inventario"
@onready var hotbar:CanvasLayer = $"Hotbar"
var instancia_encuentro = null 
var en_movimiento= true

func _ready() -> void:
	auto.mover_ruedas()
	auto.mover()
	var cinta = load("res://items/cinta.tres")
	var manzana = load("res://items/manzana.tres")
	var cigarrillo = load("res://items/cigarrillo.tres")
	var card_1 = item_card_scene.instantiate()
	$Hotbar/Control/Slot1.add_child(card_1)  
	card_1.configurar(cinta.duplicate(), true)  
	HotbarManager.colocar_item(0, cinta)
	var card_2 = item_card_scene.instantiate()
	$Hotbar/Control/Slot2.add_child(card_2)  
	card_2.configurar(manzana.duplicate(), true)
	HotbarManager.colocar_item(1, manzana)
	var card_3 = item_card_scene.instantiate()
	$Hotbar/Control/Slot3.add_child(card_3)  
	card_3.configurar(cigarrillo.duplicate(), true)
	HotbarManager.colocar_item(1, cigarrillo)

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
		
