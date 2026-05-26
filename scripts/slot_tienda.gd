extends PanelContainer
var item: Item
var item_card_scene = preload("res://scenes/item_card.tscn")
var label_precio: Label

func configurar(p_item: Item) -> void:
	item = p_item
	for hijo in get_children():
		hijo.queue_free()
	var card = item_card_scene.instantiate()
	add_child(card)
	card.configurar(item.duplicate(), true)
	card.mostrar_precio(item.precio)
	
func limpiar() -> void:
	item = null
	for hijo in get_children():
		hijo.queue_free()
	
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return false
