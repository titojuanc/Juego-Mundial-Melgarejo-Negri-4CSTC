extends Node

const MAX_SLOTS = 4
var slots: Array = [null, null, null, null]

func colocar_item(index: int, item: Item):
	slots[index] = item

func sacar_item(index: int):
	var item = slots[index]
	slots[index] = null
	return item

func esta_lleno():
	return slots.count(null) == 0

func _restaurar_hotbar(instancia_hotbar):
	for i in range(HotbarManager.MAX_SLOTS):
		var item = HotbarManager.slots[i]
		if item != null:
			var slot = instancia_hotbar.get_child(i+1)
			var card = GameManager.item_card_scene.instantiate()
			slot.add_child(card)
			card.configurar(item, true)
