extends PanelContainer
class_name ItemCard

@onready var icono: TextureRect = $Control/Icono
@onready var usos_label: Label = $LabelControl/Labels/UsosLabel
@onready var slots: Array = [
	$Control/Indicadores/Slot1,
	$Control/Indicadores/Slot2,
	$Control/Indicadores/Slot3,
	$Control/Indicadores/Slot4
	]

var item: Item
var precio_label: Label = null

func _ready() -> void:
	resized.connect(_on_resized)

func configurar(p_item: Item, nuevo : bool):
	item = p_item
	icono.texture = item.icono
	if nuevo:
		item.establecer_usos()
	actualizar_layout()
	actualizar_usos_label()

func actualizar_usos_label():
	if item == null:
		usos_label.text = ""
		usos_label.visible = false
		return
	usos_label.text = str("Usos: " , item.usos)
	usos_label.visible = true

func actualizar_layout():
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
	
	var tiene_indicadores = item.indicadores.any(func(x): return x != null)
	$Control/Indicadores.visible = tiene_indicadores
	
func cargar_icono_indicador(id : int):
	var atlas = AtlasTexture.new()
	atlas.atlas = load("res://assets/Items/items_sheet.png")
	match id:
		1: atlas.region = GameManager.INDICADORES["auto"]
		2: atlas.region = GameManager.INDICADORES["nafta"]
		3: atlas.region = GameManager.INDICADORES["energia"]
		4: atlas.region = GameManager.INDICADORES["dinero"]
	return atlas
	
func _get_drag_data(at_position: Vector2):
	if item == null:
		return
	
	GameManager.item_arrastrando = item
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
		configurar(item, true)
	
func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		GameManager.item_arrastrando = null

func mostrar_precio(precio: int):
	if precio_label == null:
		var icono: TextureRect = TextureRect.new()
		icono.texture = cargar_icono_indicador(4)
		icono.custom_minimum_size = Vector2(16, 16)
		icono.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icono.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		$LabelControl/Labels.add_child(icono)
		precio_label = Label.new()
		precio_label.size_flags_horizontal = Control.SIZE_SHRINK_END
		$LabelControl/Labels.add_child(precio_label)
	precio_label.text = str(precio)

func actualizar_usos():
	actualizar_usos_label()

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		if item is ItemConsumible:
			_mostrar_menu_usar()
			
func _mostrar_menu_usar():
	var menu = PopupMenu.new()
	menu.add_item("Usar")
	menu.add_item("Cancelar")
	add_child(menu)
	menu.position = Vector2i(global_position)
	menu.popup()
	menu.id_pressed.connect(_on_menu_seleccionado)
	
func _on_menu_seleccionado(id: int):
	if id == 0:
		_usar()
	
func _usar():
	var consumible = item as ItemConsumible
	
	if get_parent().get_script() == preload("res://scripts/slot_tienda.gd"):
		if StatsManager.dinero < item.precio:
			print("Sin dinero suficiente")
			return
		StatsManager.reducir_dinero(item.precio)
		
	match consumible.tipo_efecto:
		ItemConsumible.TipoEfecto.NAFTA:
			StatsManager.aumentar_nafta(consumible.valor)
		ItemConsumible.TipoEfecto.ENERGIA:
			StatsManager.aumentar_energia(consumible.valor)
		ItemConsumible.TipoEfecto.AUTO:
			StatsManager.aumentar_auto(consumible.valor)
	get_parent().limpiar()
