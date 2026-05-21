extends Node2D

@export var datos: Ciudad

@onready var fondo = $Fondo
@onready var estructuras = $Estructuras

var tienda_scene = preload("res://scenes/estructuras/tienda.tscn")
var garage_scene = preload("res://scenes/estructuras/garage.tscn")
var gasolineria_scene = preload("res://scenes/estructuras/gasolineria.tscn")
var hotel_scene = preload("res://scenes/estructuras/hotel.tscn")
var casa_scene = preload("res://scenes/estructuras/casa.tscn")

func _ready():
	if datos == null:
		return
	cargar_ciudad(datos)
	
func cargar_ciudad(ciudad: Ciudad):
	fondo.texture = ciudad.fondo
	
	if ciudad.tiene_tienda:
		var tienda = tienda_scene.instantiate()
		tienda.position = ciudad.posicion_tienda
		estructuras.add_child(tienda)
	
	if ciudad.tiene_garage:
		var garage = garage_scene.instantiate()
		garage.position = ciudad.posicion_garage
		estructuras.add_child(garage)
	
	if ciudad.tiene_gasolineria:
		var gasolineria = gasolineria_scene.instantiate()
		gasolineria.position = ciudad.posicion_gasolineria
		estructuras.add_child(gasolineria)
	
	if ciudad.tiene_hotel:
		var hotel = hotel_scene.instantiate()
		hotel.position = ciudad.posicion_hotel
		estructuras.add_child(hotel)
	
	if ciudad.tiene_casa:
		var casa = casa_scene.instantiate()
		casa.position = ciudad.posicion_casa
		estructuras.add_child(casa)
	
