extends EstructuraGD

@onready var color_rect = $CanvasLayer/ColorRect

var ya_usado: bool = false

func _input(event):
	if en_rango and not ya_usado and event.is_action_pressed("Interactuar"):
		ya_usado = true
		hacer_fade()

func hacer_fade():
	color_rect.modulate.a = 0.0
	color_rect.visible = true
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 1.0, 2.0)
	tween.tween_callback(dormir)
	tween.tween_interval(1.0)
	tween.tween_property(color_rect, "modulate:a", 0.0, 2.0)
	tween.tween_callback(func(): color_rect.visible = false)
	
func dormir():
	StatsManager.aumentar_energia(StatsManager.MAX_ENERGIA)
	EstadoManager.quitar_estado(Estado.Tipo.CANSANCIO)
	EstadoManager.aplicar_estado(Estado.Tipo.DESCANSADO)
