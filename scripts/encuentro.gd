extends Node2D

var Hotbar = preload("res://scenes/Hotbar_encuentro.tscn")
var auto

func _iniciar(referencia_auto: CharacterBody2D) -> void:
	auto = referencia_auto
	auto.parar_anim_player()
	var barra_de_evento = Hotbar.instantiate()
	add_child(barra_de_evento)

func configurar_peligros(evento:Resource):
	RandomNumberGenerator.randi()
	

func terminar():
	queue_free()
