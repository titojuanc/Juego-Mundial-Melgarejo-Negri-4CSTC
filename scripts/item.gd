class_name Item
extends Resource

@export var nombre: String = ""
@export var icono: AtlasTexture = null
@export var indicadores: Array = [null, null, null, null]
@export var usos_maximos: int = 1
@export var precio: int = 10

var usos

func establecer_usos():
	usos = usos_maximos
