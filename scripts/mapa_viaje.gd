extends CanvasLayer

signal cerrado

const TEXTURA_MAPA = preload("res://assets/America.jpg")

const COLOR_LINEA_SOMBRA   = Color(0.0, 0.0, 0.0, 0.5)
const COLOR_RUTA_PROXIMA   = Color(1.0, 0.85, 0.0, 1.0)   #la ruta que vas a tomar
const COLOR_RUTA_LEJANA    = Color(1.0, 0.85, 0.0, 0.35)  #rutas siguientes
const COLOR_CIUDAD_ACTUAL  = Color(0.25, 1.0, 0.25)        #donde estás
const COLOR_CIUDAD_DESTINO = Color(1.0, 0.5, 0.1)          #próxima parada
const COLOR_CIUDAD_FUTURA  = Color(1.0, 1.0, 1.0, 0.7)    #ciudades futuras

const TAMANIO_MAPA := Vector2(2300.0, 2900.0)

var ciudades: Array = []
var ruta_a_cargar: Resource = null
var ciudad_a_cargar: Ciudad = null

# para mover el mapa
var arrastrando := false
var nivel_zoom := 1.0
const ZOOM_MIN := 0.4
const ZOOM_MAX := 1.0
const ZOOM_PASO := 0.1

@onready var sub_viewport: SubViewport = $SubViewport/SubViewport
@onready var nodo_dibujo: Node2D = $SubViewport/SubViewport/MapaDraw
@onready var camara: Camera2D = $SubViewport/SubViewport/Camera2D
@onready var label_destino: Label = $CanvasLayer/Control/Label
@onready var boton_partir: Button = $CanvasLayer/Control/VBoxContainer/Partir
@onready var boton_volver: Button = $CanvasLayer/Control/VBoxContainer/Volver

func _ready() -> void:
	_recolectar_ciudades()
	nodo_dibujo.mapa = self
	if ciudades.size() >= 2:
		label_destino.text = "Próxima parada: " + ciudades[1].nombre
	else:
		label_destino.text = ""
	boton_partir.pressed.connect(_al_partir)
	boton_volver.pressed.connect(_al_volver)
	if ciudades.size() > 0:
		camara.position = _pos(ciudades[0].posicion_mapa)
	else:
		camara.position = TAMANIO_MAPA / 2.0
	_limitar_camara()
	
	nodo_dibujo.queue_redraw()

func _recolectar_ciudades() -> void:
	var c: Ciudad = GameManager.ciudad_siguiente
	if c == null:
		return
	while c != null:
		ciudades.append(c)
		c = c.ciudad_siguiente

func _pos(normalizada: Vector2) -> Vector2:
	return normalizada * TAMANIO_MAPA

func _input(evento: InputEvent) -> void:
	if evento is InputEventMouseButton:
		if evento.button_index == MOUSE_BUTTON_LEFT:
			arrastrando = evento.pressed
		elif evento.button_index == MOUSE_BUTTON_WHEEL_UP:
			nivel_zoom = clampf(nivel_zoom - ZOOM_PASO, ZOOM_MIN, ZOOM_MAX)
			camara.zoom = Vector2(1.0 / nivel_zoom, 1.0 / nivel_zoom)
			_limitar_camara()
		elif evento.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			nivel_zoom = clampf(nivel_zoom + ZOOM_PASO, ZOOM_MIN, ZOOM_MAX)
			camara.zoom = Vector2(1.0 / nivel_zoom, 1.0 / nivel_zoom)
			_limitar_camara()
	elif evento is InputEventMouseMotion and arrastrando:
		camara.position -= evento.relative * nivel_zoom
		_limitar_camara()

func _limitar_camara() -> void:
	var tamanio_visible: Vector2 = Vector2(sub_viewport.size) * nivel_zoom
	var mitad := tamanio_visible / 2.0
	camara.position.x = clampf(camara.position.x, mitad.x, max(TAMANIO_MAPA.x - mitad.x, mitad.x))
	camara.position.y = clampf(camara.position.y, mitad.y, max(TAMANIO_MAPA.y - mitad.y, mitad.y))

func _al_partir() -> void:
	GameManager.ciudad_actual = GameManager.ciudad_siguiente
	GameManager.ruta_actual = ruta_a_cargar
	GameManager.ciudad_siguiente = ciudad_a_cargar
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ruta_gameplay.tscn")

func _al_volver() -> void:
	cerrado.emit()
	queue_free()
