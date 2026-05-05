extends Control

@onready var label: Label = $Label
@onready var icono: TextureRect = $Icono

func _ready() -> void:
	label.text = str(StatsManager.dinero)
	StatsManager.dinero_cambiado.connect(_on_dinero_cambiado)
	var atlas = AtlasTexture.new()
	atlas.atlas = load("res://assets/Items/items_sheet.png")
	atlas.region = GameManager.INDICADORES["dinero"]
	icono.texture = atlas
	icono.custom_minimum_size = Vector2(20, 20)
	icono.visible = true

func _on_dinero_cambiado(valor: int) -> void:
	label.text = str(valor)
