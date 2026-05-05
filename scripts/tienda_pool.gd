class_name TiendaPool
extends Resource
@export var items: Array[Item] = []
@export var pesos: Array[int] = []  # [3, 1, 1] = 60%, 20%, 20%
@export var min_items: int = 2
@export var max_items: int = 4
