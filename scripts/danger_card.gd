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
	return get_parent()._can_drop_data(at_position, data)

func _drop_data(at_position: Vector2, data: Variant) -> void:
	get_parent()._drop_data(at_position, data)
