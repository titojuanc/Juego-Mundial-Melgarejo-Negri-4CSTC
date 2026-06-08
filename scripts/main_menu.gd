extends Control

func _on_jugar_pressed() -> void:
	GameManager.ciudad_siguiente = preload("res://ciudades/Ciudad1.tres")
	get_tree().change_scene_to_file("res://scenes/ciudad.tscn")


func _on_opciones_pressed() -> void:
	get_tree().change_scene_to_file("res://menues/opciones.tscn")


func _on_salir_pressed() -> void:
	get_tree().quit()
