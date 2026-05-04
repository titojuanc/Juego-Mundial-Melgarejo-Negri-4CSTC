extends PanelContainer
class_name DangerCard

@onready var icono: TextureRect = $Control/Icono
var peligro: Peligro

func configurar(p_peligro: Peligro) -> void:
	peligro = p_peligro
	icono.texture = peligro.icono

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if peligro == null:
		return false
	if not data is Dictionary:
		return false
	if not data.has("item") or not data.has("origen"):
		return false
	var item: Item = data["item"]
	return peligro.tipo in item.indicadores

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var origen = data["origen"]
	for hijo in origen.get_children():
		hijo.queue_free()
	
	if origen.get_script() == preload("res://scripts/slot_hotbar.gd"):
		HotbarManager.sacar_item(origen.index)
	elif origen.get_script() == preload("res://scripts/slot_inventario.gd"):
		InventarioManager.sacar_item(origen.index)
	
	queue_free()
