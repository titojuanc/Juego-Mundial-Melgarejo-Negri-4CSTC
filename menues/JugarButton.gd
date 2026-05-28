extends Button

func _on_pressed() -> void:
	GameManager.ciudad_siguiente = preload("res://ciudades/debug.tres")
	get_tree().change_scene_to_file("res://scenes/ciudad.tscn")
