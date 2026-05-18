extends Node2D

var item_card_scene = preload("res://scenes/item_card.tscn")
var danger_card = preload("res://scenes/danger_card.tscn")
var tienda_pool = preload("res://tiendas/tienda_debug.tres")

func _ready():
	var peligro_auto = load("res://items/peligros/auto.tres")
	var cinta = load("res://items/cinta.tres")
	var manzana = load("res://items/manzana.tres")
	var card_1 = item_card_scene.instantiate()
	$Hotbar/Control/Slot1.add_child(card_1)  
	card_1.configurar(cinta.duplicate(), true)  
	HotbarManager.colocar_item(0, cinta)
	var card_2 = item_card_scene.instantiate()
	$Hotbar/Control/Slot2.add_child(card_2)  
	card_2.configurar(manzana.duplicate(), true)
	HotbarManager.colocar_item(1, manzana)
	var danger_1 = danger_card.instantiate()
	$HotbarEncuentro/Control/Slot1.add_child(danger_1)  
	danger_1.configurar(peligro_auto)
	var danger_2 = danger_card.instantiate()
	$HotbarEncuentro/Control/Slot2.add_child(danger_2)  
	danger_2.configurar(peligro_auto)
	var danger_3 = danger_card.instantiate()
	$HotbarEncuentro/Control/Slot3.add_child(danger_3)  
	danger_3.configurar(peligro_auto)
	var danger_4 = danger_card.instantiate()
	$HotbarEncuentro/Control/Slot4.add_child(danger_4)  
	danger_4.configurar(peligro_auto)
	var danger_5 = danger_card.instantiate()
	$HotbarEncuentro/Control/Slot5.add_child(danger_5)  
	danger_5.configurar(peligro_auto)
	var danger_6 = danger_card.instantiate()
	$HotbarEncuentro/Control/Slot6.add_child(danger_6)  
	danger_6.configurar(peligro_auto)
	
	
func _input(event):
	if event.is_action_pressed("ui_accept"): 
		if $Tienda.visible:
			$Tienda.cerrar()
		else:
			$Tienda.abrir(tienda_pool)
	if event.is_action_pressed("ui_up"):
		StatsManager.aumentar_energia(1)
		StatsManager.aumentar_auto(1)
		StatsManager.aumentar_nafta(1)
	if event.is_action_pressed("ui_down"):
		StatsManager.reducir_energia(1)
		StatsManager.reducir_auto(1)
		StatsManager.reducir_nafta(1)
