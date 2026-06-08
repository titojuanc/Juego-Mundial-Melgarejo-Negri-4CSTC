class_name Estado
extends Resource

enum Tipo {CANSANCIO, HAMBRIENTO, FLOW, DESCANSADO, COMIDO}

@export var nombre: String = ""
@export var descripcion: String = ""
@export var icono: AtlasTexture = null
@export var tipo: Tipo
