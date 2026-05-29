extends Node2D

var encuentro = preload("res://scenes/Encuentro.tscn")
var item_card_scene = preload("res://scenes/item_card.tscn") #Del test. Depsués borrar

#Lo va a cargar la ciudad de donde viene
var ruta = GameManager.ruta_actual
var siguiente_ciudad = GameManager.ciudad_siguiente

@onready var auto:CharacterBody2D = $Auto
@onready var fondo:Control = $Ruta_1
@onready var inventario:CanvasLayer = $"Inventario"
@onready var timer_ruta: Timer = $Timer
var timer_eventos = Timer.new() #Esto podría ser un nodo predefinido también.

var instancia_encuentro = null 
var en_movimiento= true
var randomizador = RandomNumberGenerator.new()
var eventos_ocurridos = 0


func _ready() -> void:
	HotbarManager._restaurar_hotbar($Hotbar/Control)
	InventarioManager._restaurar_inventario($Inventario/Control)
	GameManager.terminar_evento.connect(on_terminar_evento)
	GameManager.empezar_evento.connect(on_empezar_evento)
	#Test. después sacar.
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
	instancia_encuentro.terminar()
	en_movimiento=true
	inventario.cerrar_forzado()
	auto.mover()
	
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
	instancia_encuentro._iniciar()
	var peligros_a_usar
	if EstadoManager._tiene_estado(Estado.Tipo.CANSANCIO):
		peligros_a_usar = ruta.encuentros_cansado
	else:
		peligros_a_usar = ruta.encuentros
	instancia_encuentro.configurar_peligros(peligros_a_usar[randomizador.randi_range(0, peligros_a_usar.size()-1)])
	inventario.bloquear_por_evento()
	auto.parar_anim_player()

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
	#estuve buscando y la solución para esto era meter una lambda, pq sino era como que la llamaba en un callback o algo así  no sé estoy cansado :/
	tween.tween_callback(func(): get_tree().change_scene_to_file("res://scenes/ciudad.tscn"))
