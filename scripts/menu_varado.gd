extends CanvasLayer
class_name Varado
signal elegir_rendirse
signal elegir_inventario
signal elegir_mecanico

@onready var boton_rendirse: Button = $Control/Button
@onready var boton_mecanico: Button = $Control/ButtonMecanico
@onready var boton_inventario: Button = $Control/ButtonInventario
@onready var boton_dormir: Button = $Control/ButtonDormir
@onready var label_costo: Label = $Control/Label2

var costo_mecanico: int = 200

func _ready() -> void:
	_crear_overlay()
	_actualizar_botones()
	boton_rendirse.pressed.connect(_on_rendirse)
	boton_mecanico.pressed.connect(_on_mecanico)
	boton_inventario.pressed.connect(_on_inventario)
	boton_dormir.pressed.connect(_on_dormir)
	
func _actualizar_botones() -> void:
	var sin_nafta = StatsManager.nafta == 0
	var sin_auto = StatsManager.vida_auto == 0
	var sin_energia = StatsManager.energia == 0
	
	# Mecánico: visible si hay problema mecánico, disabled si no hay plata
	boton_mecanico.visible = sin_nafta or sin_auto
	boton_mecanico.disabled = StatsManager.dinero < costo_mecanico
	label_costo.text = "$" + str(costo_mecanico)
	label_costo.visible = boton_mecanico.visible
	
	# Dormir: visible solo si sin energía
	boton_dormir.visible = sin_energia
	
func _on_rendirse() -> void:
	elegir_rendirse.emit()
	
func _on_mecanico() -> void:
	StatsManager.reducir_dinero(costo_mecanico)
	if StatsManager.nafta == 0:
		StatsManager.aumentar_nafta(StatsManager.MAX_NAFTA)
	if StatsManager.vida_auto == 0:
		StatsManager.aumentar_auto(StatsManager.MAX_AUTO)
	elegir_mecanico.emit()
	_chequear_si_sigue_varado()
	
func _on_dormir() -> void:
	StatsManager.aumentar_energia(StatsManager.MAX_ENERGIA)
	EstadoManager.aplicar_estado(Estado.Tipo.CANSANCIO)
	_chequear_si_sigue_varado()
	
func _on_inventario() -> void:
	elegir_inventario.emit()
	
func _chequear_si_sigue_varado() -> void:
	var sin_nafta = StatsManager.nafta == 0
	var sin_auto = StatsManager.vida_auto == 0
	var sin_energia = StatsManager.energia == 0
	if sin_nafta or sin_auto or sin_energia:
		_actualizar_botones()
	else:
		hide()
	
func _crear_overlay() -> void:
	var overlay = ColorRect.new()
	overlay.color = Color(0, 0, 0, 0)
	overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(overlay)
	move_child(overlay, 0)
	var tween = create_tween()
	tween.tween_property(overlay, "color:a", 0.6, 0.5)
