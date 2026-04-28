extends Node2D

var item_card_scene = preload("res://scenes/item_card.tscn")

func _ready():
	var cinta = load("res://items/cinta.tres")
	var card = item_card_scene.instantiate()
	$Hotbar/HBoxContainer.add_child(card)  
	card.configurar(cinta)                       
