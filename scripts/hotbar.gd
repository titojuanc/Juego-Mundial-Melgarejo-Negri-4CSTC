extends CanvasLayer

var usos_label: Label = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/Slot1.index = 0
	$Control/Slot2.index = 1
	$Control/Slot3.index = 2
	$Control/Slot4.index = 3

func mostrar_usos(item: Item, global_pos: Vector2):
	if usos_label == null:
		usos_label = Label.new()
		add_child(usos_label)
	
	usos_label.text = "Usos: %d" % item.usos
	usos_label.visible = true
	usos_label.global_position = global_pos + Vector2(0, -30)
	
func ocultar_usos():
	if usos_label:
		usos_label.visible = false
