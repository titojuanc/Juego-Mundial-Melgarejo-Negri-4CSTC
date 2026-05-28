extends Resource
class_name Ruta

enum TipoRuta {AUTOPISTA, RIPIO, TIERRA, BOSQUE}

@export var encuentros: Array[Resource] = []
@export var encuentros_cansado: Array[Resource] = []
@export var cant_eventos: int
@export var tipo:TipoRuta
# podrían también hacer aparecer distintas escenas en el fondo según el evento
# por ejemplo, rueda pinchada haría que se frene el auto, peaje aparecería un peaje
