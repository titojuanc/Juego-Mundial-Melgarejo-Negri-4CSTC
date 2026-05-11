extends Node2D

var Hotbar = preload("res://scenes/Hotbar_encuentro.tscn")
var auto
var barra

func _iniciar(referencia_auto: CharacterBody2D) -> void:
	auto = referencia_auto
	auto.parar_anim_player()
	var barra_de_evento = Hotbar.instantiate()
	barra=barra_de_evento
	add_child(barra_de_evento)

func configurar_peligros(evento:Resource):
	var hotbar_peligros = ["", "", "", "", "", "", "", "" ]
	var danger_cards = {
						"auto": load("res://items/peligros/auto.tres"),
						"nafta": load("res://items/peligros/nafta.tres"), 
						"energia": load("res://items/peligros/energia.tres"), 
						"dinero": load("res://items/peligros/dinero.tres")
						}
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


func colocar_eventos():
	pass

func terminar():
	queue_free()
