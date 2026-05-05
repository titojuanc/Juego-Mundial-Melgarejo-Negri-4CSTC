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

func _ready() -> void:
	resized.connect(_on_resized)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func configurar(p_item: Item):
	item = p_item
	icono.texture = item.icono
	_actualizar_layout()

func _actualizar_layout():
	var panel_size = size
	if panel_size == Vector2.ZERO:
		return
	
	var slot_size = min(panel_size.x, panel_size.y) * 0.25
	slot_size = max(slot_size, 8.0)
	for i in range(4):
		if i < item.indicadores.size() and item.indicadores[i] != null:
			var id = item.indicadores[i]
			slots[i].texture = cargar_icono_indicador(id)
			slots[i].custom_minimum_size = Vector2(slot_size, slot_size)
			slots[i].expand_mode = TextureRect.EXPAND_FIT_WIDTH
			slots[i].stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		else:
			slots[i].texture = null
			slots[i].custom_minimum_size = Vector2(0, 0)

func cargar_icono_indicador(id : int):
	var atlas = AtlasTexture.new()
	atlas.atlas = load("res://assets/Items/items_sheet.png")
	match id:
		#Ahi las defini globalmente
		1: atlas.region = GameManager.INDICADORES["auto"]
		2: atlas.region = GameManager.INDICADORES["nafta"]
		3: atlas.region = GameManager.INDICADORES["energia"]
		4: atlas.region = GameManager.INDICADORES["dinero"]
	return atlas
	
func _get_drag_data(at_position: Vector2):
	if item == null:
		return
	
	GameManager.item_arrastrando = item
	print("Arrastrando: ", GameManager.item_arrastrando)
	var datos = {
		"item": item,
		"origen": get_parent()
	}
	
	var preview = TextureRect.new()
	preview.texture = item.icono
	preview.custom_minimum_size = Vector2(55, 55)
	preview.expand_mode = TextureRect.EXPAND_FIT_WIDTH
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	set_drag_preview(preview)
	
	return datos
	
func _on_resized():
	if item != null:
		configurar(item)
	
func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		print("Drag terminado, limpiando")
		GameManager.item_arrastrando = null
	
func _on_mouse_entered():
	if item != null:
		var canvas = get_tree().get_first_node_in_group("Hotbar")
		canvas.mostrar_usos(item, global_position)
	
func _on_mouse_exited():
		var canvas = get_tree().get_first_node_in_group("Hotbar")
		canvas.ocultar_usos()
