extends Node2D

var datos: Ciudad = GameManager.ciudad_siguiente

@onready var estructuras = $Estructuras
@onready var hotbar_slots = $UI/Hotbar/Control
@onready var inventario_slots = $UI/Inventario/Control
@onready var spawn_jugador = $Marker2D
@onready var fondo = $Background
@onready var road = $Background/TextureRect

var jugador
var salida_nodo
var camara

func _ready():
	if datos == null:
		return
	
	jugador = GameManager.auto_scene.instantiate()
	jugador.global_position = spawn_jugador.global_position
	camara = Camera2D.new()
	jugador.add_child(camara)
	
	cargar_ciudad(datos)
	
	camara.limit_left = 0
	camara.limit_top = 0
	road.size.x = camara.limit_right
	
	HotbarManager._restaurar_hotbar(hotbar_slots)
	InventarioManager._restaurar_inventario(inventario_slots)
	_restaurar_stats()
	_restaurar_estados()
	
func cargar_ciudad(ciudad: Ciudad):
	if ciudad.tiene_tienda:
		var tienda = datos.tienda.instantiate()
		tienda.position = ciudad.posicion_tienda
		estructuras.add_child(tienda)
		tienda.get_node("Tienda").pool = ciudad.tienda_pool
	
	if ciudad.tiene_garage:
		var garage = datos.garage.instantiate()
		garage.position = ciudad.posicion_garage
		estructuras.add_child(garage)
	
	if ciudad.tiene_gasolineria:
		var gasolineria = datos.gasolineria.instantiate()
		gasolineria.position = ciudad.posicion_gasolineria
		estructuras.add_child(gasolineria)
	
	if ciudad.tiene_hotel:
		var hotel = datos.hotel.instantiate()
		hotel.position = ciudad.posicion_hotel
		estructuras.add_child(hotel)
	
	if ciudad.tiene_casa:
		var casa = datos.casa.instantiate()
		casa.position = ciudad.posicion_casa
		estructuras.add_child(casa)
	
	var salida = datos.exit.instantiate()
	salida.position = ciudad.posicion_exit
	salida.ruta = ciudad.ruta_siguiente
	salida.ciudad_siguiente = ciudad.ciudad_siguiente
	estructuras.add_child(salida)
	salida_nodo = salida
	
	var ancho = int(salida_nodo.position.x) + 1000
	var fondos = [ciudad.fondo, ciudad.fondo1, ciudad.fondo2, ciudad.fondo3, ciudad.fondo4, ciudad.fondo5]
	for texture in fondos:
		print("Textura: ", texture)
		if texture != null:
			var rect = TextureRect.new()
			rect.texture = texture
			rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			rect.size = Vector2(ancho, get_viewport().get_visible_rect().size.y)
			rect.position = Vector2.ZERO
			rect.stretch_mode = TextureRect.STRETCH_TILE
			fondo.add_child(rect)
	
func _restaurar_stats():
	StatsManager.emit_signal("energia_cambiada", StatsManager.energia)
	StatsManager.emit_signal("nafta_cambiada", StatsManager.nafta)
	StatsManager.emit_signal("auto_cambiado", StatsManager.vida_auto)
	StatsManager.emit_signal("dinero_cambiado", StatsManager.dinero)
	
func _restaurar_estados():
	EstadoManager.emit_signal("estados_cambiados")
