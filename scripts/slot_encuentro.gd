extends PanelContainer

var index: int

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if not data is Dictionary:
		return false
	if not data.has("item") or not data.has("origen"):
		return false
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	var item: Item = data["item"]
	var origen = data["origen"]
	var slots_a_borrar = _calcular_slots_a_borrar(item)
	
	if slots_a_borrar.is_empty():
		return
	
	for i in slots_a_borrar:
		var slot = _get_slot(i)
		if slot:
			for hijo in slot.get_children():
				if hijo is DangerCard:
					hijo.queue_free()
		
	for hijo in origen.get_children():
		hijo.queue_free()
	if origen.get_script() == preload("res://scripts/slot_hotbar.gd"):
		HotbarManager.sacar_item(origen.index)
	elif origen.get_script() == preload("res://scripts/slot_inventario.gd"):
		InventarioManager.sacar_item(origen.index)

func _buscar_secuencia_valida(item: Item) -> int:
	var indicadores = item.indicadores.filter(func(x): return x != null)
	print("Indicadores filtrados: ", indicadores)
	if indicadores.is_empty():
		return -1
	var parent = get_parent()
	for i in range(indicadores.size()):
		var slot_vecino = null
		for slot in parent.get_children():
			if slot.get("index") == index + i:
				slot_vecino = slot
				break
		if slot_vecino == null:
			return -1
		var dc = null
		for hijo in slot_vecino.get_children():
			if hijo is DangerCard:
				dc = hijo
				break
		print("Slot %d: dc=%s, tipo=%s" % [index + i, dc, dc.peligro.tipo if dc else "null"])
		if dc == null or dc.peligro.tipo != indicadores[i]:
			return -1
	return indicadores.size()
	
func _calcular_slots_a_borrar(item: Item) -> Array:
	var indicadores = item.indicadores.filter(func(x): return x != null)
	var a_borrar = []
	var slot_actual = index
	
	for indicador in indicadores:
		var slot = _get_slot(slot_actual)
		var dc = _get_danger_card(slot)
		if dc != null and dc.peligro.tipo == indicador:
			a_borrar.append(slot_actual)
		slot_actual += 1
	return a_borrar

func _get_slot(i: int) -> Node:
	for slot in get_parent().get_children():
		if slot.get("index") == i:
			return slot
	return null
	
func _get_danger_card(slot: Node) -> DangerCard:
	if slot == null:
		return null
	for hijo in slot.get_children():
		if hijo is DangerCard:
			return hijo
	return null
