extends PanelContainer
class_name EstadoCard

@onready var icono: TextureRect = $Control/Icono
@onready var tooltip_panel: PanelContainer = $TooltipPanel
@onready var tooltip_nombre: Label = $TooltipPanel/VBoxContainer/Nombre
@onready var tooltip_descripcion: Label = $TooltipPanel/VBoxContainer/Descripcion

var tooltip_timer: SceneTreeTimer = null
var estado: Estado

func configurar(p_estado: Estado) -> void:
	estado = p_estado
	icono.texture = estado.icono
	tooltip_nombre.text = estado.nombre
	tooltip_descripcion.text = estado.descripcion
	
func _on_mouse_entered() -> void:
	icono.hide()
	tooltip_panel.visible = true
	
func _on_mouse_exited() -> void:
	icono.show()
	tooltip_panel.visible = false
