class_name Ciudad
extends Resource

@export var nombre: String = ""
@export var fondo: Texture2D = null
@export var pais: String = ""
@export var descripcion: String = ""
@export var ruta_siguiente: Resource
@export var ciudad_siguiente: Ciudad

@export var tiene_tienda: bool = false
@export var tienda: PackedScene
@export var posicion_tienda: Vector2 = Vector2.ZERO
@export var tienda_pool: TiendaPool

@export var tiene_garage: bool = false
@export var garage: PackedScene
@export var posicion_garage: Vector2 = Vector2.ZERO

@export var tiene_gasolineria: bool = false
@export var gasolineria: PackedScene
@export var posicion_gasolineria: Vector2 = Vector2.ZERO

@export var tiene_hotel: bool = false
@export var hotel: PackedScene
@export var posicion_hotel: Vector2 = Vector2.ZERO

@export var tiene_casa: bool = false
@export var casa: PackedScene
@export var posicion_casa: Vector2 = Vector2.ZERO

@export var exit: PackedScene
@export var posicion_exit: Vector2 = Vector2.ZERO
