extends Node2D

var scriptAuto = load("res://scenes/auto.tscn")
var auto

func _iniciar() -> void:
	auto.parar_ruedas()
