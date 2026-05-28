extends PanelContainer
class_name DangerCard

@onready var icono: TextureRect = $Control/Icono
var peligro: Peligro
var es_preview: bool = false

func _ready() -> void:
	if es_preview:
		mouse_filter = Control.MOUSE_FILTER_IGNORE

func configurar(p_peligro: Peligro) -> void:
	peligro = p_peligro
	icono.texture = peligro.icono

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if get_parent().has_method("_can_drop_data"):
		return get_parent()._can_drop_data(at_position, data)
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if get_parent().has_method("_drop_data"):
		get_parent()._drop_data(at_position, data)
