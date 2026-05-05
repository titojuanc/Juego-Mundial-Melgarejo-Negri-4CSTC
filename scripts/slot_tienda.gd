extends PanelContainer
var item: Item
var item_card_scene = preload("res://scenes/item_card.tscn")

func configurar(p_item: Item) -> void:
	item = p_item
	for hijo in get_children():
		hijo.queue_free()
	var card = item_card_scene.instantiate()
	add_child(card)
	card.configurar(item)
	
func limpiar() -> void:
	item = null
	for hijo in get_children():
		hijo.queue_free()
