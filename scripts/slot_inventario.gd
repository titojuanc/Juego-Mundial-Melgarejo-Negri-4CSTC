extends PanelContainer

var index: int
var item_card_scene = preload("res://scenes/item_card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _can_drop_data(at_position: Vector2, data: Variant):
	if not data is Dictionary:
		return false
	if not data.has("item"):
		return false
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	print("origen script: ", data["origen"].get_script())
	print("es slot_tienda: ", data["origen"].get_script() == preload("res://scripts/slot_tienda.gd"))
	var item = data["item"]
	var origen = data["origen"]
	if InventarioManager.slots[index] != null:
		return
	
	if origen.get_script() == preload("res://scripts/slot_tienda.gd"):
		if StatsManager.dinero < item.precio:
			return
		StatsManager.reducir_dinero(item.precio)
		origen.limpiar()
	else:
		for hijo in origen.get_children():
			hijo.queue_free()
		if origen.get_script() == preload("res://scripts/slot_hotbar.gd"):
			HotbarManager.sacar_item(origen.index)
		else:
			InventarioManager.sacar_item(origen.index)
	
	var card = item_card_scene.instantiate()
	add_child(card)
	card.configurar(item, false)
	InventarioManager.colocar_item(index, item)

func limpiar() -> void:
	for hijo in get_children():
		hijo.queue_free()
	InventarioManager.sacar_item(index)
