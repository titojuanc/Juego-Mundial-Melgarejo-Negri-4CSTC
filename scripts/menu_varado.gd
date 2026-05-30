extends CanvasLayer

signal elegir_rendirse
signal elegir_inventario
signal elegir_mecanico

@onready var boton_rendirse: Button = $Control/Button
@onready var boton_mecanico: Button = $Control/ButtonMecanico
@onready var boton_inventario: Button = $Control/ButtonInventario
@onready var label_costo: Label = $Control/Label2

var costo_mecanico: int = 200

func _ready() -> void:
	_crear_overlay()
	
	label_costo.text = "$" + str(costo_mecanico)
	
	# Deshabilitar mecánico si no alcanza el dinero
	if StatsManager.dinero < costo_mecanico:
		boton_mecanico.disabled = true
	
	boton_rendirse.pressed.connect(_on_rendirse)
	boton_mecanico.pressed.connect(_on_mecanico)
	boton_inventario.pressed.connect(_on_inventario)

func _crear_overlay() -> void:
	var overlay = ColorRect.new()
	overlay.color = Color(0, 0, 0, 0)
	overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(overlay)
	move_child(overlay, 0) # detrás del panel pero bloqueando clics al juego
	
	var tween = create_tween()
	tween.tween_property(overlay, "color:a", 0.6, 0.5)

func _on_rendirse() -> void:
	elegir_rendirse.emit()

func _on_mecanico() -> void:
	StatsManager.reducir_dinero(costo_mecanico)
	elegir_mecanico.emit()

func _on_inventario() -> void:
	elegir_inventario.emit()
