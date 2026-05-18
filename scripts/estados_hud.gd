extends CanvasLayer

@onready var slots = [
	$Control/Slot1,
	$Control/Slot2,
	$Control/Slot3,
	$Control/Slot4,
	$Control/Slot5
]

var estado_card_scene = preload("res://scenes/estado_card.tscn")

func _ready():
	EstadoManager.estados_cambiados.connect(_actualizar)
	
func _actualizar():
	for slot in slots:
		for hijo in slot.get_children():
			hijo.queue_free()
	for i in range(EstadoManager.estados_activos.size()):
		if i >= slots.size():
			break
		var card = estado_card_scene.instantiate()
		slots[i].add_child(card)
		card.configurar(EstadoManager.estados_activos[i])
