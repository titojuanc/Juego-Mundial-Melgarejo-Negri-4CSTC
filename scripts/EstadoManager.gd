extends Node

var estados_activos: Array[Estado] = []

signal estados_cambiados

func aplicar_estado(tipo: String) -> void:
	if _tiene_estado(tipo):
		return
	var estado = _cargar_estado(tipo)
	if estado == null:
		return
	estados_activos.append(estado)
	_aplicar_efecto(tipo)
	emit_signal("estados_cambiados")
	
func quitar_estado(tipo: String) -> void:
	for i in range(estados_activos.size()):
		if estados_activos[i].tipo == tipo:
			estados_activos.remove_at(i)
			_revertir_efecto(tipo)
			emit_signal("estados_cambiados")
			return
	
func _tiene_estado(tipo: String) -> bool:
	for e in estados_activos:
		if e.tipo == tipo:
			return true
	return false
	
func _aplicar_efecto(tipo: String) -> void:
	match tipo:
		"cansancio":
			StatsManager.MAX_ENERGIA -= 1
			StatsManager.energia = min(StatsManager.energia, StatsManager.MAX_ENERGIA)
			StatsManager.emit_signal("energia_cambiada", StatsManager.energia)
		"hambriento":
			print("Futura Logica")
		"flow":
			StatsManager.reduccion_peligros += 1
		"descansado":
			StatsManager.reduccion_dificultad += 1
		"comido":
			print("Futura Logica")
	
func _revertir_efecto(tipo: String) -> void:
	match tipo:
		"cansancio":
			StatsManager.MAX_ENERGIA += 1
		"hambriento":
			print("Futura Logica")
		"flow":
			StatsManager.reduccion_peligros -= 1
		"descansado":
			StatsManager.reduccion_dificultad -= 1
		"comido":
			print("Futura Logica")
	
func _cargar_estado(tipo: String) -> Estado:
	return load("res://estados/" + tipo + ".tres")
