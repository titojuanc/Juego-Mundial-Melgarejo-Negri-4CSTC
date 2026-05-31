class_name Ciudad
extends Resource

@export var nombre: String = ""
## Posición normalizada (0.0 a 1.0) sobre America.jpg para dibujar en el mapa
@export var posicion_mapa: Vector2 = Vector2(0.5, 0.5)

@export var fondo: Texture2D = null
@export var fondo1: Texture2D = null
@export var fondo2: Texture2D = null
@export var fondo3: Texture2D = null
@export var fondo4: Texture2D = null
@export var fondo5: Texture2D = null

@export var pais: String = ""
@export var descripcion: String = ""
@export var ruta_siguiente: Resource
@export var ciudad_siguiente: Ciudad

@export var tiene_tienda: bool = false
@export var tienda: PackedScene
@export var posicion_tienda: Vector2 = Vector2(0, 210)
@export var tienda_pool: TiendaPool

@export var tiene_garage: bool = false
@export var garage: PackedScene
@export var posicion_garage: Vector2 = Vector2(0, 399)

@export var tiene_gasolineria: bool = false
@export var gasolineria: PackedScene
@export var posicion_gasolineria: Vector2 = Vector2(0, 190)

@export var tiene_hotel: bool = false
@export var hotel: PackedScene
@export var posicion_hotel: Vector2 = Vector2(0, 272)

@export var tiene_casa: bool = false
@export var casa: PackedScene
@export var posicion_casa: Vector2 = Vector2(0, 336)

@export var exit: PackedScene
@export var posicion_exit: Vector2 = Vector2(0, 439)
