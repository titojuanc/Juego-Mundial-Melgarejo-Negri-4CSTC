extends Node2D

var item_card_scene = preload("res://scenes/item_card.tscn")
var danger_card = preload("res://scenes/danger_card.tscn")

func _ready():
	var peligro_auto = load("res://items/peligros/auto.tres")
	var cinta = load("res://items/cinta.tres")
	var manzana = load("res://items/manzana.tres")
	var card_1 = item_card_scene.instantiate()
	$Hotbar/Control/Slot1.add_child(card_1)  
	card_1.configurar(cinta)
	print(str(card_1.icono))     
	HotbarManager.colocar_item(0, cinta)
	var card_2 = item_card_scene.instantiate()
	$Hotbar/Control/Slot2.add_child(card_2)  
	card_2.configurar(manzana)
	HotbarManager.colocar_item(1, manzana)
	var danger_1 = danger_card.instantiate()
	$HotbarEncuentro/Control/Slot2.add_child(danger_1)  
	danger_1.configurar(peligro_auto)
	var danger_2 = danger_card.instantiate()
	$HotbarEncuentro/Control/Slot3.add_child(danger_2)  
	danger_2.configurar(peligro_auto)
	
func _input(event):
	if event.is_action_pressed("ui_up"):
		StatsManager.aumentar_energia(1)
		StatsManager.aumentar_auto(1)
		StatsManager.aumentar_nafta(1)
	if event.is_action_pressed("ui_down"):
		StatsManager.reducir_energia(1)
		StatsManager.reducir_auto(1)
		StatsManager.reducir_nafta(1)

func _drop_data(at_position: Vector2, data: Variant) -> void:
	print("drop en debug")
