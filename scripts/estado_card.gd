extends PanelContainer
class_name EstadoCard

@onready var icono: TextureRect = $Control/Icono

var estado: Estado

func configurar(p_estado: Estado) -> void:
	estado = p_estado
	icono.texture = estado.icono
