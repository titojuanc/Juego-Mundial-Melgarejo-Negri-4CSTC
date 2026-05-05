extends CanvasLayer

var danger_card_scene = preload("res://scenes/danger_card.tscn")
var preview_cards: Array = []
var slots_highlighted: Array = []
var preview_activo: bool = false
var altura_card = 100
@onready var slots_encuentro = [
	$Control/Slot1,
	$Control/Slot2,
	$Control/Slot3,
	$Control/Slot4,
	$Control/Slot5,
	$Control/Slot6,
	$Control/Slot7,
	$Control/Slot8
]

func _ready() -> void:
	slots_encuentro[0].index = 0
	slots_encuentro[1].index = 1
	slots_encuentro[2].index = 2
	slots_encuentro[3].index = 3
	slots_encuentro[4].index = 4
	slots_encuentro[5].index = 5
	slots_encuentro[6].index = 6
	slots_encuentro[7].index = 7
	
func _process(_delta: float) -> void:
	if GameManager.item_arrastrando == null:
		if preview_activo:
			_limpiar_preview()
			preview_activo = false
		return
		
	var mouse = get_viewport().get_mouse_position()
	var rect = $Control.get_global_rect()
	var dentro = rect.has_point(mouse)
	if dentro and not preview_activo:
		preview_activo = true
		_mostrar_preview(GameManager.item_arrastrando)
	elif not dentro and preview_activo:
		preview_activo = false
		_limpiar_preview()
	
	
func _on_zona_entered():
	print("Entró al control, item_arrastrando: ", GameManager.item_arrastrando)
	if GameManager.item_arrastrando == null:
		return
	_mostrar_preview(GameManager.item_arrastrando)

func _on_zona_exited():
	_limpiar_preview()

func _mostrar_preview(item: Item):
	_limpiar_preview()
	var indicadores = item.indicadores.filter(func(x): return x != null)
	for i in range(indicadores.size()):
		if i >= slots_encuentro.size():
			break
		var peligro_temp = Peligro.new()
		peligro_temp.tipo = indicadores[i]
		peligro_temp.icono = _cargar_icono_indicador(indicadores[i])
		var card = danger_card_scene.instantiate()
		$Control.add_child(card)
		card.configurar(peligro_temp)
		card.position = Vector2(slots_encuentro[i].position.x, slots_encuentro[i].position.y - altura_card)
		print("global_position slot: ", slots_encuentro[i].global_position)
		print("position slot: ", slots_encuentro[i].position)
		print("card position: ", card.position)
		preview_cards.append(card)
		
func _limpiar_preview():
	for card in preview_cards:
		if is_instance_valid(card):
			card.queue_free()
	preview_cards.clear()
	_limpiar_highlights()
	
func _limpiar_highlights():
	for slot in slots_highlighted:
		if is_instance_valid(slot):
			slot.modulate = Color.WHITE
	slots_highlighted.clear()
	

func _cargar_icono_indicador(id: int) -> AtlasTexture:
	var atlas = AtlasTexture.new()
	atlas.atlas = load("res://assets/Items/items_sheet.png")
	match id:
		1: atlas.region = GameManager.INDICADORES["auto"]
		2: atlas.region = GameManager.INDICADORES["nafta"]
		3: atlas.region = GameManager.INDICADORES["energia"]
		4: atlas.region = GameManager.INDICADORES["dinero"]
	return atlas
