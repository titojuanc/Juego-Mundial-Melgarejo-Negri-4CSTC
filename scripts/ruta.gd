extends Resource
class_name Ruta

enum TipoRuta {AUTOPISTA, RIPIO, TIERRA, BOSQUE}

@export var encuentros: Array[Resource] = []
@export var cant_eventos: int
@export var tipo:TipoRuta
