extends Node

enum Turno {PROPIO, EXTRA, RUTA}

signal eliminar_carta
signal terminar_evento
signal empezar_evento 
signal cambiar_turno(turno: String)
signal ejecutar_turno_ruta

var turno_actual: Turno = Turno.PROPIO

var item_arrastrando: Item = null
var danger_card = load("res://scenes/danger_card.tscn")

const INDICADORES = {
	"auto": Rect2(528.624, 400.607, 14.589, 14.713),
	"nafta": Rect2(64.73, 416.69, 14.335, 14.713),
	"energia": Rect2(145.655, 416.587, 13.665, 13.81),
	"dinero": Rect2(128.644, 512.736, 14.742, 13.809)
}

const PELIGROS = {
	"auto":preload("res://items/peligros/auto.tres"),
	"nafta":preload("res://items/peligros/nafta.tres"),
	"energia":preload("res://items/peligros/energia.tres"),
	"dinero":preload("res://items/peligros/dinero.tres")
}

func _ready() -> void:
	cambiar_turno.connect(_on_cambiar_turno)

func puede_dropear() -> bool:
	return turno_actual == Turno.PROPIO or turno_actual == Turno.EXTRA

func crear_peligro() -> DangerCard:
	var peligro = danger_card.instantiate()
	return peligro

func obtener_peligro(nombre) -> Peligro:
	return PELIGROS[nombre]

func crear_icono_dinero(icono):
	var atlas = AtlasTexture.new()
	atlas.atlas = load("res://assets/Items/items_sheet.png")
	atlas.region = GameManager.INDICADORES["dinero"]
	icono.texture = atlas
	icono.custom_minimum_size = Vector2(20, 20)
	icono.visible = true

func _on_cambiar_turno(turno):
	match turno:
		"propio":
			turno_actual = Turno.PROPIO
			print("tu turno")
		"extra":
			turno_actual = Turno.EXTRA
			print("turno extra")
		"ruta":
			turno_actual = Turno.RUTA
			ejecutar_turno_ruta.emit()
			print("turno ruta")
