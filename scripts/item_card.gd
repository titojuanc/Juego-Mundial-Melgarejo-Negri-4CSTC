extends PanelContainer
class_name ItemCard

@onready var icono: TextureRect = $Control/Icono
@onready var slots: Array = [
	$Control/Indicadores/Slot1,
	$Control/Indicadores/Slot2,
	$Control/Indicadores/Slot3,
	$Control/Indicadores/Slot4
	]
	
var item: Item

func configurar(p_item: Item):
	#p_item sería el sprite?
	#es el tres okok
	item = p_item
	icono.texture = item.icono
	
	for i in range (4):
		if i < item.indicadores.size() and item.indicadores[i] != null:
			var id = item.indicadores[i]
			slots[i].texture = cargar_icono_indicador(id)
			slots[i].custom_minimum_size = Vector2(15, 15)
		else:
			slots[i].texture = null
			slots[i].custom_minimum_size = Vector2(0, 0)

func cargar_icono_indicador(id : int):
	var atlas = AtlasTexture.new()
	atlas.atlas = load("res://assets/Items/items_sheet.png")
	match id:
		#acá se definieron los íconos de las 4 stats. Deberíamos definirlos en algo más global, para acceder a ellos más cómodamente.
		1: atlas.region = Rect2(528.624, 400.607, 14.589, 14.713)
		2: atlas.region = Rect2(64.73, 416.69, 14.335, 14.713)
		3: atlas.region = Rect2(145.655, 416.587, 13.665, 13.81)
		4: atlas.region = Rect2(128.644, 512.736, 14.742, 13.809)
	return atlas
	
func _get_drag_data(at_position: Vector2):
	if item == null:
		return
	var preview = TextureRect.new()
	preview.texture = item.icono
	set_drag_preview(preview)
	
	return item
