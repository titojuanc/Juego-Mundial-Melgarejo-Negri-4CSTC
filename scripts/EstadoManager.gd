extends Node

var estados_activos: Array[Estado] = []

signal estados_cambiados

func aplicar_estado(tipo) -> void:
	if _tiene_estado(tipo):
		return
	var estado = _cargar_estado(tipo)
	if estado == null:
		return
	estados_activos.append(estado)
	_aplicar_efecto(tipo)
	emit_signal("estados_cambiados")
	
func quitar_estado(tipo) -> void:
	for i in range(estados_activos.size()):
		if estados_activos[i].tipo == tipo:
			estados_activos.remove_at(i)
			_revertir_efecto(tipo)
			emit_signal("estados_cambiados")
			return
	
func _tiene_estado(tipo) -> bool:
	for e in estados_activos:
		if e.tipo == tipo:
			return true
	return false
	
func _aplicar_efecto(tipo) -> void:
	match tipo:
		Estado.Tipo.CANSANCIO:
			StatsManager.MAX_ENERGIA -= 1
			StatsManager.energia = min(StatsManager.energia, StatsManager.MAX_ENERGIA)
			StatsManager.emit_signal("energia_cambiada", StatsManager.energia)
		Estado.Tipo.HAMBRIENTO:
			print("Futura Logica")
		Estado.Tipo.FLOW:
			print("Futura Logica")
		Estado.Tipo.DESCANSADO:
			print("Futura Logica")
		Estado.Tipo.COMIDO:
			print("Futura Logica")
	
func _revertir_efecto(tipo) -> void:
	match tipo:
		Estado.Tipo.CANSANCIO:
			StatsManager.MAX_ENERGIA += 1
		Estado.Tipo.HAMBRIENTO:
			print("Futura Logica")
		Estado.Tipo.FLOW:
			print("Futura Logica")
		Estado.Tipo.DESCANSADO:
			print("Futura Logica")
		Estado.Tipo.COMIDO:
			print("Futura Logica")
	
func _cargar_estado(tipo) -> Estado:
	var nombre = Estado.Tipo.keys()[tipo].to_lower()
	print("Cargando estado: res://estados/" + nombre + ".tres")
	return load("res://estados/" + nombre + ".tres")
