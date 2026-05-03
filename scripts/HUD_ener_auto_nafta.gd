extends CanvasLayer

@onready var energia_llena: Sprite2D = $Control/Energia/Lleno
@onready var auto_lleno: Sprite2D = $Control/Auto/Lleno
@onready var nafta_llena: Sprite2D = $Control/Nafta/Lleno

var region_original: Rect2

func _ready():
	region_original = energia_llena.region_rect
	StatsManager.energia_cambiada.connect(actualizar_energia)
	StatsManager.auto_cambiado.connect(actualizar_auto)
	StatsManager.nafta_cambiada.connect(actualizar_nafta)
	
func actualizar_sprite(valor, constante, barra):
	var porcentaje = float(valor) / float(constante)
	var nuevo_ancho = region_original.size.x * porcentaje
	barra.region_rect = Rect2(
		region_original.position.x,
		region_original.position.y,
		region_original.size.x * porcentaje,
		region_original.size.y
	)
	barra.offset.x = -(region_original.size.x - nuevo_ancho) / 2
	
func actualizar_energia(valor):
	actualizar_sprite(valor, StatsManager.MAX_ENERGIA, energia_llena)
	
func actualizar_auto(valor):
	actualizar_sprite(valor, StatsManager.MAX_AUTO, auto_lleno)
	
func actualizar_nafta(valor):
	actualizar_sprite(valor, StatsManager.MAX_NAFTA, nafta_llena)
