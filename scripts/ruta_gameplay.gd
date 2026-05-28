extends Node2D

var encuentro = preload("res://scenes/Encuentro.tscn")
var item_card_scene = preload("res://scenes/item_card.tscn") #Del test. Depsués borrar
var ruta = preload("res://rutas/ruta_1_alaska.tres")

@onready var auto:CharacterBody2D = $Auto
@onready var fondo:Control = $Ruta_1
@onready var inventario:CanvasLayer = $"Inventario"
@onready var hotbar:CanvasLayer = $"Hotbar"
@onready var timer_ruta: Timer = $Timer
var timer_eventos = Timer.new() #Esto podría ser un nodo predefinido también.

var instancia_encuentro = null 
var en_movimiento= true
var randomizador = RandomNumberGenerator.new()
var eventos_ocurridos = 0


func _ready() -> void:
	GameManager.terminar_evento.connect(on_terminar_evento)
	GameManager.empezar_evento.connect(on_empezar_evento)
	GameManager
	#Test. después sacar.
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
	
	#la ruta va a durar 20 segundos andando. Esto cambiaría según el auto o la distancia
	var intervalo = timer_ruta.wait_time / ruta.cant_eventos
	timer_eventos.one_shot = true
	add_child(timer_eventos)
	timer_eventos.wait_time = intervalo
	timer_eventos.timeout.connect(on_empezar_evento)
	
	timer_eventos.start()
	timer_ruta.start()
	fondo.reanudar()
	auto.mover()

func on_terminar_evento() -> void:
	timer_ruta.paused = false 
	fondo.reanudar()
	auto.mover()
	instancia_encuentro.terminar()
	en_movimiento=true
	inventario.cerrar_forzado()
	
	if eventos_ocurridos < ruta.cant_eventos:
		timer_eventos.start()
	else:
		terminar_ruta()

func on_empezar_evento() -> void:
	eventos_ocurridos += 1
	timer_ruta.paused = true 
	fondo.parar() 
	en_movimiento=false
	instancia_encuentro = encuentro.instantiate()
	add_child(instancia_encuentro)
	instancia_encuentro._iniciar(auto)
	instancia_encuentro.configurar_peligros(ruta.encuentros[randomizador.randi_range(0, ruta.encuentros.size()-1)])
	inventario.bloquear_por_evento()

func terminar_ruta() -> void:
	#el canvas es para que se dibuje por encima de todo
	var canvas = CanvasLayer.new()
	canvas.layer=100
	add_child(canvas)
	
	var pantalla_transicion = ColorRect.new()
	pantalla_transicion.color = Color(0, 0, 0, 0) #invisible
	pantalla_transicion.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(pantalla_transicion)
	
	var tween = create_tween()
	tween.tween_property(pantalla_transicion, "color:a", 1.0, 1.5)
	tween.tween_callback(get_tree().quit)
