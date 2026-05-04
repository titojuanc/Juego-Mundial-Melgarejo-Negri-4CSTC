extends Node2D

var scriptAuto = load("res://scenes/auto.tscn")
var auto

func _iniciar(referencia_auto: CharacterBody2D) -> void:
	auto = referencia_auto
	auto.parar_anim_player()

func terminar():
	queue_free()
