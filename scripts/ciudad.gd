class_name Ciudad
extends Resource

@export var nombre: String = ""
@export var fondo: Texture2D = null
@export var pais: String = ""
@export var descripcion: String = ""

@export var tiene_tienda: bool = false
@export var posicion_tienda: Vector2 = Vector2.ZERO

@export var tiene_garage: bool = false
@export var posicion_garage: Vector2 = Vector2.ZERO

@export var tiene_gasolineria: bool = false
@export var posicion_gasolineria: Vector2 = Vector2.ZERO

@export var tiene_hotel: bool = false
@export var posicion_hotel: Vector2 = Vector2.ZERO

@export var tiene_casa: bool = false
@export var posicion_casa: Vector2 = Vector2.ZERO
