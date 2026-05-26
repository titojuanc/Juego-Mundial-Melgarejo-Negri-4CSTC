class_name ItemConsumible
extends Item

enum TipoEfecto {NAFTA, ENERGIA, AUTO}

@export var tipo_efecto: TipoEfecto = TipoEfecto.NAFTA
@export var valor: int = 1
