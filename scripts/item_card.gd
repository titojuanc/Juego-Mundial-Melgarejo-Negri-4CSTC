extends PanelContainer
class_name ItemCard

@onready var icono: TextureRect = $VBoxContainer/Icono
@onready var nombre: Label = $VBoxContainer/Nombre
@onready var slots: Array = [
	$VBoxContainer/Indicadores/Slot1,
	$VBoxContainer/Indicadores/Slot2,
	$VBoxContainer/Indicadores/Slot3,
	$VBoxContainer/Indicadores/Slot4
	]
	
var item: Item

func configurar(p_item: Item):
	item = p_item
	icono.texture = item.icono
	nombre.text = item.nombre
	
	for i in range (4):
		if item.indicadores[i] != null:
			var id = item.indicadores[i]
			slots[i].texture = cargar_icono_indicador(id)
		else:
			slots[i].texture = null

func cargar_icono_indicador(id : int):
	match id:
		1: return load("res://assets/Indicadores/Auto.png")
		2: return load("res://assets/Indicadores/Nafta.png")
		3: return load("res://assets/Indicadores/Energia.png")
		4: return load("res://assets/Indicadores/Dinero.png")
	return null
	
func _get_drag_data(at_position: Vector2):
	if item == null:
		return
	var preview = TextureRect.new()
	preview.texture = item.icono
	set_drag_preview(preview)
	
	return item
	

	
