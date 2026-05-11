extends Control

@onready var label: Label = $Label
@onready var icono: TextureRect = $Icono

func _ready() -> void:
	label.text = str(StatsManager.dinero)
	StatsManager.dinero_cambiado.connect(_on_dinero_cambiado)
	crear_icono()

func _on_dinero_cambiado(valor: int) -> void:
	label.text = str(valor)

func crear_icono():
	GameManager.crear_icono_dinero(icono)
