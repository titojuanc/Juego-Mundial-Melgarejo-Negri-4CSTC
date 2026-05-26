extends Node2D

var Hotbar = preload("res://scenes/Hotbar_encuentro.tscn")
var danger_card = preload("res://scenes/danger_card.tscn")
@onready var mensaje = $Label

var auto
var barra
var hotbar_peligros = ["", "", "", "", "", "", "", "" ]

func _iniciar(referencia_auto: CharacterBody2D) -> void:
	auto = referencia_auto
	auto.parar_anim_player()
	var barra_de_evento = Hotbar.instantiate()
	barra=barra_de_evento
	GameManager.eliminar_carta.connect(_on_peligro_eliminado)
	get_parent().add_child(barra_de_evento)
	mensaje.text = "tu turno"
	GameManager.cambiar_turno("propio")

func configurar_peligros(evento:Resource):
	
	var aleatorizador = RandomNumberGenerator.new()
	
	var minimo_total =0
	for minimo in evento.minimos:
		minimo_total += evento.minimos[minimo]
	
	var maximo_total=0
	for maximo in evento.maximos:
		maximo_total+=evento.maximos[maximo]
	
	var claves = evento.peligros.keys()
	
	var conteo = {}
	for clave in claves:
		conteo[clave] = 0 
	
	var chances_extra = [50.0, 25.0, 20.0]
	var orden = [3, 4, 2, 5, 1, 6, 0, 7]
	var cursor = 0
	
	var i = 0
	while i < minimo_total:
		var pendientes = [] #aca se guardan los minimos
		for clave in claves:
			if conteo[clave] < evento.minimos[clave] and evento.peligros[clave] != 0:
				pendientes.append(clave)
		
		if pendientes.is_empty(): # si el evento es totalmente random, no hace nada
			break
		
		var peligro = pendientes[aleatorizador.randi_range(0, pendientes.size()-1)]
		var chance = evento.peligros[peligro]
		var roll = aleatorizador.randf_range(0.0, 100.0)
		if roll < chance:
			if conteo[peligro] < evento.maximos[peligro] or evento.maximos[peligro]==0: #aca se controla los maximos
				hotbar_peligros[orden[cursor]] = peligro
				conteo[peligro] += 1
				i += 1
				cursor +=1
	
	for peligro in evento.minimos:
		var faltan = evento.minimos[peligro] - conteo[peligro]
		if faltan > 0:
			for j in range(faltan):
				hotbar_peligros[orden[cursor]] = peligro
				conteo[peligro] += 1
				cursor +=1
	
	for chance_extra in chances_extra:
		var disponibles = [] 
		for clave in claves:
			if conteo[clave] < evento.maximos[clave] and evento.peligros[clave] != 0:
				disponibles.append(clave)
		
		if disponibles.is_empty(): #no hay mas peligros para poner
			break
		var peligro =  disponibles[aleatorizador.randi_range(0, disponibles.size()-1)]
		var roll = aleatorizador.randf_range(0.0, 100.0)
		if roll < chance_extra:
			if conteo[peligro] < evento.maximos[peligro] or evento.maximos[peligro]==0: #aca se controla los maximos
				hotbar_peligros[orden[cursor]] = peligro
				conteo[peligro] += 1
				cursor +=1
				
			
	print(hotbar_peligros)
	colocar_eventos(hotbar_peligros)

func colocar_eventos(lista):
	var i = 0
	for peligro in lista:
		if peligro == "":
			i = i+1
			continue
		else:
			var slot = barra.slots_encuentro[i]
			var carta_peligro = GameManager.crear_peligro() 
			slot.add_child(carta_peligro)
			carta_peligro.configurar(GameManager.obtener_peligro(peligro))
			i = i+1
	pass

func _on_peligro_eliminado()-> void:
	var eliminar = true
	for slot in barra.slots_encuentro:
		if slot.get_children().is_empty():
			continue
		else:
			eliminar = false
	if eliminar:
		barra.queue_free()
		GameManager.terminar_evento.emit()
	else:
		reordenar()


func reordenar() -> void:
	var iz = 3
	var der = 4
	ordenar_izquierda(iz)
	ordenar_derecha(der)
	centrar()
	pass

func ordenar_izquierda(i):
	if i >= 1:
		var slot_derecha = barra.slots_encuentro[i]
		var slot_izquierda = barra.slots_encuentro[i-1]
		if slot_derecha.get_children().is_empty() and not slot_izquierda.get_children().is_empty():
			var carta = slot_izquierda.get_child(0)
			slot_izquierda.remove_child(carta)
			slot_derecha.add_child(carta)
		ordenar_izquierda(i-1)
	else:
		return

func ordenar_derecha(i):
	if i < barra.slots_encuentro.size() - 1:
		var slot_izquierda = barra.slots_encuentro[i]
		var slot_derecha = barra.slots_encuentro[i+1]
		if slot_izquierda.get_children().is_empty() and not slot_derecha.get_children().is_empty():
			var carta = slot_derecha.get_child(0)
			slot_derecha.remove_child(carta)
			slot_izquierda.add_child(carta)
		ordenar_derecha(i+1)
	else:
		return

func centrar():
	var peligros = []
	for slot in barra.slots_encuentro:
		if not slot.get_children().is_empty():
			var carta = slot.get_child(0)
			slot.remove_child(carta)
			peligros.append(carta)
	var inicio = (barra.slots_encuentro.size() - peligros.size()) / 2
	
	for i in range(peligros.size()):
		barra.slots_encuentro[inicio + i].add_child(peligros[i])
	
	# Actualizar index de todos los slots
	for i in range(barra.slots_encuentro.size()):
		barra.slots_encuentro[i].index = i

func terminar():
	queue_free()
