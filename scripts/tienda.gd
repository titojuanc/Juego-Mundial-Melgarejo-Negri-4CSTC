extends CanvasLayer
@export var pool: TiendaPool
var slots: Array = []

func _ready() -> void:
	slots = [
		$Control/Slot1,
		$Control/Slot2,
		$Control/Slot3,
		$Control/Slot4,
		$Control/Slot5,
		$Control/Slot6,
		$Control/Slot7,
		$Control/Slot8,
		$Control/Slot9,
		$Control/Slot10,
		$Control/Slot11,
		$Control/Slot12,
		$Control/Slot13,
		$Control/Slot14,
		$Control/Slot15,
		$Control/Slot16,
		$Control/Slot17,
		$Control/Slot18,
		$Control/Slot19,
		$Control/Slot20,
		$Control/Slot21,
		$Control/Slot22,
		$Control/Slot23,
		$Control/Slot24,
		$Control/Slot25,
		$Control/Slot26,
		$Control/Slot27,
		$Control/Slot28,
		$Control/Slot29,
		$Control/Slot30,
	]

func abrir(p_pool: TiendaPool = null) -> void:
	if p_pool:
		pool = p_pool
	_generar()
	show()

func cerrar() -> void:
	hide()
	for slot in slots:
		slot.limpiar()

func _generar() -> void:
	var cantidad = randi_range(pool.min_items, pool.max_items)
	for slot in slots:
		slot.limpiar()
	for i in range(min(cantidad, slots.size())):
		slots[i].configurar(_elegir_item())

func _elegir_item() -> Item:
	var total_peso = 0
	for peso in pool.pesos:
		total_peso += peso
	var sorte = randi_range(1, total_peso)
	var acumulado = 0
	for i in range(pool.items.size()):
		acumulado += pool.pesos[i]
		if sorte <= acumulado:
			return pool.items[i]
	return pool.items[-1]
	
	
