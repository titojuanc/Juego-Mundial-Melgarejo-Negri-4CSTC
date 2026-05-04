extends Node2D

var encuentro = preload("res://scenes/Encuentro.tscn")
@onready var auto:CharacterBody2D = $Auto
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		var instancia_encuentro = encuentro.instantiate()
		instancia_encuentro.auto = auto
		add_child(instancia_encuentro)
