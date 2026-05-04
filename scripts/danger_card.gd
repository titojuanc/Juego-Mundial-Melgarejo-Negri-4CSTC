extends PanelContainer
class_name DangerCard

@onready var icono: TextureRect = $Control/Icono
var peligro: Peligro

func _ready() -> void:
	print("DangerCard lista: ", name)
	print("Mouse filter: ", mouse_filter)

func configurar(p_peligro: Peligro) -> void:
	peligro = p_peligro
	icono.texture = peligro.icono

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	print("=== _can_drop_data llamado en DangerCard ===")
	if peligro == null:
		print("  -> peligro es null, retorna false")
		return false
	if not data is Dictionary:
		print("  -> data no es Dictionary, retorna false")
		return false
	if not data.has("item") or not data.has("origen"):
		print("  -> data no tiene item/origen, retorna false")
		return false
	var item: Item = data["item"]
	print("  -> peligro.tipo=", peligro.tipo, " | item.indicadores=", item.indicadores)
	var resultado = peligro.tipo in item.indicadores
	print("  -> resultado: ", resultado)
	return resultado

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var origen = data["origen"]
	for hijo in origen.get_children():
		hijo.queue_free()
	if origen.get_script() == preload("res://scripts/slot_hotbar.gd"):
		HotbarManager.sacar_item(origen.index)
	elif origen.get_script() == preload("res://scripts/slot_inventario.gd"):
		InventarioManager.sacar_item(origen.index)
	queue_free()

func _notification(what):
	print("notificacion: ", what)
