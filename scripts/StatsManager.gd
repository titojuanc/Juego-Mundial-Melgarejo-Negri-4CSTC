extends Node

var MAX_ENERGIA = 6
var MAX_NAFTA = 6
var MAX_AUTO = 6
const DINERO_INICIAL = 500

var energia: int = MAX_ENERGIA
var nafta: int = MAX_NAFTA
var vida_auto: int = MAX_AUTO
var dinero: int = DINERO_INICIAL
var reduccion_peligros: int = 0     # cuántos peligros menos aparecen
var reduccion_dificultad: int = 0   # modificador de dificultad

signal energia_cambiada(valor)
signal nafta_cambiada(valor)
signal auto_cambiado(valor)
signal dinero_cambiado(valor)
signal max_energia_cambiada(valor)

func reducir_energia(cantidad):
	energia = max(0, energia - cantidad)
	emit_signal("energia_cambiada", energia)
	chequear_energia()

func aumentar_energia(cantidad):
	energia = min(energia + cantidad, MAX_ENERGIA)
	emit_signal("energia_cambiada", energia)
	_chequear_resolucion_varado()

func chequear_energia():
	if energia == 0:
		GameManager.emit_signal("varado", "energia")
	if energia < MAX_ENERGIA * 0.5:
		EstadoManager.aplicar_estado(Estado.Tipo.CANSANCIO)
		EstadoManager.quitar_estado(Estado.Tipo.DESCANSADO)
	elif energia > MAX_ENERGIA * 0.75:
		EstadoManager.aplicar_estado(Estado.Tipo.DESCANSADO)
		EstadoManager.quitar_estado(Estado.Tipo.CANSANCIO)
	else:
		EstadoManager.quitar_estado(Estado.Tipo.CANSANCIO)
		EstadoManager.quitar_estado(Estado.Tipo.DESCANSADO)
		
func reducir_nafta(cantidad):
	nafta = max(0, nafta - cantidad)
	emit_signal("nafta_cambiada", nafta)
	chequear_nafta()
	
func aumentar_nafta(cantidad):
	nafta = min(nafta + cantidad, MAX_NAFTA)
	emit_signal("nafta_cambiada", nafta)
	_chequear_resolucion_varado()

func chequear_nafta():
	if nafta == 0:
		GameManager.emit_signal("varado", "nafta")

func reducir_auto(cantidad):
	vida_auto = max(0, vida_auto - cantidad)
	emit_signal("auto_cambiado", vida_auto)
	chequear_auto()
	
func aumentar_auto(cantidad):
	vida_auto = min(vida_auto + cantidad, MAX_AUTO)
	emit_signal("auto_cambiado", vida_auto)
	_chequear_resolucion_varado()

func chequear_auto():
	if vida_auto == 0:
		
		#Costo mecanido exponencial por llamada - Futura logica
		GameManager.emit_signal("varado", "auto")

func reducir_dinero(cantidad):
	dinero = max(0, dinero - cantidad)
	emit_signal("dinero_cambiado", dinero)

func aumentar_dinero(cantidad):
	dinero += cantidad
	emit_signal("dinero_cambiado", dinero)

func get_multiplicador_dificultad() -> float:
	var porcentaje = float(energia) / float(MAX_ENERGIA)
	# 100% energia = dificultad normal (1.0), 0% energia = dificultad máxima (2.0 por ejemplo)
	return 2.0 - porcentaje

func _chequear_resolucion_varado():
	if nafta > 0 and vida_auto > 0 and energia > 0:
		GameManager.emit_signal("varado_resuelto")
