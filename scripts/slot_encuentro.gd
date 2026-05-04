extends PanelContainer

var index: int

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if not data is Dictionary:
		return false
	if not data.has("item") or not data.has("origen"):
		return false
		
	for hijo in get_children():
		if hijo is DangerCard:
			return hijo._can_drop_data(at_position, data)
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	for hijo in get_children():
		if hijo is DangerCard:
			hijo._drop_data(at_position, data)
			return
	
	var origen = data["origen"]
	for hijo in origen.get_children():
		hijo.queue_free()
	if origen.get_script() == preload("res://scripts/slot_hotbar.gd"):
		HotbarManager.sacar_item(origen.index)
	elif origen.get_script() == preload("res://scripts/slot_inventario.gd"):
		InventarioManager.sacar_item(origen.index)
