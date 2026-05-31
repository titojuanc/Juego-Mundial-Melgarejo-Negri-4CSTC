extends Node2D

const TEXTURA_MAPA = preload("res://assets/America.jpg")
const TAMANIO_MAPA = Vector2(2300.0, 2900.0)

var mapa  # referencia al script mapa_viaje.gd

func _draw() -> void:
	if mapa == null:
		return

	draw_texture_rect(TEXTURA_MAPA, Rect2(Vector2.ZERO, TAMANIO_MAPA), false)

	var ciudades = mapa.ciudades
	if ciudades.is_empty():
		return

	var fuente := ThemeDB.fallback_font
	var tamanio_fuente := 20

	for i in range(ciudades.size() - 1):
		var desde: Vector2 = ciudades[i].posicion_mapa * TAMANIO_MAPA
		var hasta: Vector2 = ciudades[i + 1].posicion_mapa * TAMANIO_MAPA
		var color_linea: Color = mapa.COLOR_RUTA_PROXIMA if i == 0 else mapa.COLOR_RUTA_LEJANA
		draw_line(desde, hasta, mapa.COLOR_LINEA_SOMBRA, 9.0)
		draw_line(desde, hasta, color_linea, 5.0)

	for i in range(ciudades.size()):
		var pos: Vector2 = ciudades[i].posicion_mapa * TAMANIO_MAPA
		var color_ciudad: Color
		if i == 0:
			color_ciudad = mapa.COLOR_CIUDAD_ACTUAL
		elif i == 1:
			color_ciudad = mapa.COLOR_CIUDAD_DESTINO
		else:
			color_ciudad = mapa.COLOR_CIUDAD_FUTURA

		draw_circle(pos, 16.0, Color(0.0, 0.0, 0.0, 0.5))
		draw_circle(pos, 13.0, color_ciudad)

		var nombre: String = ciudades[i].nombre
		var pos_texto := pos + Vector2(18.0, 6.0)
		draw_string(fuente, pos_texto + Vector2(1, 1), nombre,
				HORIZONTAL_ALIGNMENT_LEFT, -1, tamanio_fuente, Color(0, 0, 0, 0.85))
		draw_string(fuente, pos_texto, nombre,
				HORIZONTAL_ALIGNMENT_LEFT, -1, tamanio_fuente, Color.WHITE)
