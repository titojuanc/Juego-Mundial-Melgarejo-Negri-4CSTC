extends CanvasLayer

var bloqueado: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide() #Es lo mismo que hacer |visible = false|
	var index = 0
	for hijo in $Control.get_children():
		if hijo is PanelContainer:
			hijo.index = index
			index+=1
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("abrir_inventario"):
		if bloqueado:
			return
		if visible:
			hide()
		else:
			show() # visible = true

func abrir_forzado() -> void:
	bloqueado = true
	show()
	
func cerrar_forzado() -> void:
	bloqueado = false
	hide()
	
func bloquear_por_evento() -> void:
	bloqueado = true
	hide()
