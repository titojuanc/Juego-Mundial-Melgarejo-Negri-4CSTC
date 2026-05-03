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
