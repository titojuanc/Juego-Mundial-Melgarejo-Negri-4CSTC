extends CanvasLayer

@onready var energia_llena: Sprite2D = $Control/Energia/Lleno
@onready var auto_lleno: Sprite2D = $Control/Auto/Lleno
@onready var nafta_llena: Sprite2D = $Control/Nafta/Lleno
@onready var energia_vacia: Sprite2D = $Control/Energia/Vacio
@onready var auto_vacio: Sprite2D = $Control/Auto/Vacio
@onready var nafta_vacia: Sprite2D = $Control/Nafta/Vacio

var region_original_energia: Rect2
var region_original_auto: Rect2
var region_original_nafta: Rect2
var region_original: Rect2

func _ready():
	region_original_energia = energia_llena.region_rect
	region_original_auto = auto_lleno.region_rect
	region_original_nafta = nafta_llena.region_rect
	StatsManager.energia_cambiada.connect(actualizar_energia)
	StatsManager.max_energia_cambiada.connect(func(_nuevo_max): actualizar_energia(StatsManager.energia))
	StatsManager.auto_cambiado.connect(actualizar_auto)
	StatsManager.nafta_cambiada.connect(actualizar_nafta)
	actualizar_energia(StatsManager.energia)
	actualizar_auto(StatsManager.vida_auto)
	actualizar_nafta(StatsManager.nafta)
	
func actualizar_sprite(valor: int, maximo: int, maximo_absoluto: int, lleno: Sprite2D, vacio: Sprite2D, region_original: Rect2):
	var porcentaje_max = float(maximo) / float(maximo_absoluto)
	var porcentaje_valor = float(valor) / float(maximo_absoluto)
	var ancho_max = region_original.size.x * porcentaje_max
	var ancho_valor = region_original.size.x * porcentaje_valor
	vacio.region_rect = Rect2(region_original.position.x, region_original.position.y, ancho_max, region_original.size.y)
	vacio.offset.x = -(region_original.size.x - ancho_max) / 2
	lleno.region_rect = Rect2(region_original.position.x, region_original.position.y, ancho_valor, region_original.size.y)
	lleno.offset.x = -(region_original.size.x - ancho_valor) / 2
	
func actualizar_energia(valor):
	actualizar_sprite(valor, StatsManager.MAX_ENERGIA, 6, energia_llena, energia_vacia, region_original_energia)
	
func actualizar_auto(valor):
	actualizar_sprite(valor, StatsManager.MAX_AUTO, 6, auto_lleno, auto_vacio, region_original_auto)
	
func actualizar_nafta(valor):
	actualizar_sprite(valor, StatsManager.MAX_NAFTA, 6, nafta_llena, nafta_vacia, region_original_nafta)
