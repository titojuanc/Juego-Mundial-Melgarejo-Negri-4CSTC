extends Node2D

var item_card_scene = preload("res://scenes/item_card.tscn")
func _ready():
	var cinta = load("res://items/cinta.tres")
	var manzana = load("res://items/manzana.tres")
	var card_1 = item_card_scene.instantiate()
	$Hotbar/Control/Slot1.add_child(card_1)  
	card_1.configurar(cinta)               
	var card_2 = item_card_scene.instantiate()
	$Hotbar/Control/Slot2.add_child(card_2)  
	card_2.configurar(manzana)               

func _input(event):
	if event.is_action_pressed("ui_up"):
		StatsManager.aumentar_energia(1)
		StatsManager.aumentar_auto(1)
		StatsManager.aumentar_nafta(1)
	if event.is_action_pressed("ui_down"):
		StatsManager.reducir_energia(1)
		StatsManager.reducir_auto(1)
		StatsManager.reducir_nafta(1)
