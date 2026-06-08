extends Node

const MAX_SLOTS = 30
var slots: Array = []

func _ready():
	for i in range(MAX_SLOTS):
		slots.append(null)

func agregar_item(item: Item) -> bool:
	for i in range(MAX_SLOTS):
		if slots[i] == null:
			slots[i] = item
			return true
	return false 

func sacar_item(index: int) -> Item:
	var item = slots[index]
	slots[index] = null
	return item

func esta_lleno() -> bool:
	return slots.count(null) == 0
	
func colocar_item(index: int, item: Item):
	slots[index] = item

func _restaurar_inventario(instancia_inventario):
	for i in range(InventarioManager.MAX_SLOTS):
		var item = InventarioManager.slots[i]
		if item != null:
			var slot = instancia_inventario.get_child(i+1)
			var card = GameManager.item_card_scene.instantiate()
			slot.add_child(card)
			card.configurar(item, true)
