extends Node2D

var encuentro = preload("res://scenes/Encuentro.tscn")
var menu_varado_scene = preload("res://scenes/menu_varado.tscn")
var menu = null

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
	StatsManager._restaurar_stats()
	GameManager.terminar_evento.connect(on_terminar_evento)
	GameManager.empezar_evento.connect(on_empezar_evento)
	GameManager.varado.connect(on_varado)
	
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
	
func on_varado(_motivo: String) -> void:
	if menu != null:
		return
	timer_ruta.paused = true
	fondo.parar()
	auto.parar_anim_player()
	menu = menu_varado_scene.instantiate()
	add_child(menu)
	#acá descubrimos que se podían hacer minifunciones para no alargar el código.
	menu.elegir_rendirse.connect(func(): get_tree().change_scene_to_file("res://menues/main_menu.tscn"))
	menu.elegir_inventario.connect(_on_varado_abrir_inventario)
	menu.elegir_mecanico.connect(func(): if is_instance_valid(menu): menu.queue_free(); menu = null; terminar_ruta())
	GameManager.varado_resuelto.connect(_on_varado_resuelto, CONNECT_ONE_SHOT)

func on_terminar_evento() -> void:
	instancia_encuentro.terminar()
	instancia_encuentro = null
	inventario.cerrar_forzado()
	
	# Si quedó varado durante el evento, no reanudar la ruta
	if menu != null:
		return
	
	timer_ruta.paused = false
	fondo.reanudar()
	en_movimiento = true
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

func _on_varado_abrir_inventario() -> void:
	inventario.layer = menu.layer + 10  # por encima del menú y su overlay
	inventario.abrir_desde_varado()
	inventario.inventario_cerrado.connect(_on_inventario_cerrado_desde_varado, CONNECT_ONE_SHOT)

func _on_inventario_cerrado_desde_varado() -> void:
	inventario.layer = 1  # restaurar capa original

func _on_varado_resuelto() -> void:
	if menu != null:
		menu.queue_free()
		menu = null
	# Si el encuentro ya terminó y era el último, terminar la ruta
	if instancia_encuentro == null and eventos_ocurridos >= ruta.cant_eventos:
		terminar_ruta()
		return
	timer_ruta.paused = false
	fondo.reanudar()
	auto.mover()
