extends Node2D

@export var datos: Ciudad

@onready var fondo = $Ruta_1/Parallax2D/TextureRect
@onready var estructuras = $Estructuras
@onready var hotbar_slots = $UI/Hotbar/Control
@onready var inventario_slots = $UI/Inventario/Control
@onready var spawn_jugador = $Marker2D

var jugador


func _ready():
	if datos == null:
		return
	cargar_ciudad(datos)
	_restaurar_hotbar()
	_restaurar_inventario()
	_restaurar_stats()
	_restaurar_estados()
	
	jugador = GameManager.auto_scene.instantiate()
	jugador.global_position = spawn_jugador
	var camara = Camera2D.new()
	jugador.add_child(camara)
	camara.limit_left = 0
	camara.limit_top = 0
	camara.limit_right
	
func cargar_ciudad(ciudad: Ciudad):
	fondo.texture = ciudad.fondo
	
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
	
func _restaurar_hotbar():
	for i in range(HotbarManager.MAX_SLOTS):
		var item = HotbarManager.slots[i]
		if item != null:
			var slot = hotbar_slots.get_child(i)
			var card = GameManager.item_card_scene.instantiate()
			slot.add_child(card)
			card.configurar(item)
	
	
func _restaurar_inventario():
	for i in range(InventarioManager.MAX_SLOTS):
		var item = InventarioManager.slots[i]
		if item != null:
			var slot = inventario_slots.get_child(i)
			var card = GameManager.item_card_scene.instantiate()
			slot.add_child(card)
			card.configurar(item)
	
func _restaurar_stats():
	StatsManager.emit_signal("energia_cambiada", StatsManager.energia)
	StatsManager.emit_signal("nafta_cambiada", StatsManager.nafta)
	StatsManager.emit_signal("auto_cambiado", StatsManager.vida_auto)
	StatsManager.emit_signal("dinero_cambiado", StatsManager.dinero)
	
func _restaurar_estados():
	EstadoManager.emit_signal("estados_cambiados")
