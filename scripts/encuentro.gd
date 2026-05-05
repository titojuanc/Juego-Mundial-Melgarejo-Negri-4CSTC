extends Node2D

var Hotbar = preload("res://scenes/Hotbar_encuentro.tscn")
var auto

func _iniciar(referencia_auto: CharacterBody2D) -> void:
	auto = referencia_auto
	auto.parar_anim_player()
	var barra_de_evento = Hotbar.instantiate()
	add_child(barra_de_evento)

func configurar_peligros(evento:Resource):
	var hotbar_peligros = ["", "", "", "", "", "", "", "" ]
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
	
	var i = 0
	while i < minimo_total:
		var peligro = claves[aleatorizador.randi_range(0, 3)]
		var chance = evento.peligros[peligro]
		var roll = aleatorizador.randf_range(0.0, 100.0)
		if roll < chance:
			if conteo[peligro] < evento.maximos[peligro]:
				print("apareció " + peligro)
				hotbar_peligros[i] = peligro
				conteo[peligro] += 1
				i += 1
			else:
				print("maximo de "+peligro+" alcanzado.")
		else:
			print("no apareció " + peligro)
	
	for peligro in evento.minimos:
		var faltan = evento.minimos[peligro] - conteo[peligro]
		if faltan > 0:
			for j in range(faltan):
				hotbar_peligros[i] = peligro
				conteo[peligro] += 1
				i += 1
	
	print(hotbar_peligros)


func terminar():
	queue_free()
