extends Node

var item_arrastrando: Item = null

const INDICADORES = {
	"auto": Rect2(528.624, 400.607, 14.589, 14.713),
	"nafta": Rect2(64.73, 416.69, 14.335, 14.713),
	"energia": Rect2(145.655, 416.587, 13.665, 13.81),
	"dinero": Rect2(128.644, 512.736, 14.742, 13.809)
}

func crear_icono_dinero(icono):
	var atlas = AtlasTexture.new()
	atlas.atlas = load("res://assets/Items/items_sheet.png")
	atlas.region = GameManager.INDICADORES["dinero"]
	icono.texture = atlas
	icono.custom_minimum_size = Vector2(20, 20)
	icono.visible = true
