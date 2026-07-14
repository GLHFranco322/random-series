extends Control

@onready var scroll: ScrollContainer = $ScrollLista
@onready var lista: VBoxContainer = $ScrollLista/ListaSeries
@onready var fondo: ColorRect = $FondoImagen

var items: Array[Control] = []

const ANCHOS: Array[float] = [600.0, 480.0, 380.0]
const COLORES_FONDO: Array[Color] = [
	Color(0.55, 0.0, 0.0),
	Color(0.85, 0.3, 0.3),
	Color(0.95, 0.75, 0.75)
]
const COLORES_TEXTO: Array[Color] = [
	Color.BLACK,
	Color(0.25, 0.25, 0.25),
	Color(0.5, 0.5, 0.5)
]
const TAMANOS_FUENTE: Array[int] = [32, 24, 20]
const COLORES_FONDO_PLACEHOLDER: Array[Color] = [
	Color(0.5, 0.5, 0.55),
	Color(0.4, 0.5, 0.6),
	Color(0.55, 0.3, 0.3)
]

func _ready() -> void:
	scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_SHOW_NEVER
	
	for child in lista.get_children():
		items.append(child)

	for i in items.size():
		items[i].focus_entered.connect(_on_item_focus_entered.bind(i))

	await get_tree().process_frame
	_agregar_espaciadores()

	if items.size() > 0:
		items[0].grab_focus()
		_actualizar_estilos(0)
		_actualizar_fondo(0)
		await get_tree().process_frame
		_centrar_item(items[0])

func _agregar_espaciadores() -> void:
	var alto_medio: float = scroll.size.y / 2.0

	var espaciador_top := Control.new()
	espaciador_top.custom_minimum_size = Vector2(0, alto_medio)
	lista.add_child(espaciador_top)
	lista.move_child(espaciador_top, 0)

	var espaciador_bottom := Control.new()
	espaciador_bottom.custom_minimum_size = Vector2(0, alto_medio)
	lista.add_child(espaciador_bottom)

func _on_item_focus_entered(indice: int) -> void:
	_actualizar_estilos(indice)
	_actualizar_fondo(indice)
	_centrar_item(items[indice])

func _actualizar_estilos(indice_foco: int) -> void:
	for i in items.size():
		var item: Button = items[i]
		var distancia: int = clamp(abs(i - indice_foco), 0, ANCHOS.size() - 1)

		var tween_ancho := create_tween()
		tween_ancho.tween_property(item, "custom_minimum_size:x", ANCHOS[distancia], 0.15)

		var estilo := StyleBoxFlat.new()
		estilo.bg_color = COLORES_FONDO[distancia]
		estilo.corner_radius_top_right = 8
		estilo.corner_radius_bottom_right = 8
		item.add_theme_stylebox_override("normal", estilo)
		item.add_theme_stylebox_override("focus", estilo)
		item.add_theme_stylebox_override("hover", estilo)

		item.add_theme_color_override("font_color", COLORES_TEXTO[distancia])
		item.add_theme_font_size_override("font_size", TAMANOS_FUENTE[distancia])

func _actualizar_fondo(indice_foco: int) -> void:
	var color_objetivo: Color = COLORES_FONDO_PLACEHOLDER[indice_foco % COLORES_FONDO_PLACEHOLDER.size()]
	var tween_fondo := create_tween()
	tween_fondo.tween_property(fondo, "color", color_objetivo, 0.3)

func _centrar_item(item: Control) -> void:
	var centro_viewport: float = scroll.size.y / 2.0
	var centro_item: float = item.position.y + item.size.y / 2.0
	var destino: float = centro_item - centro_viewport

	var tween_scroll := create_tween()
	tween_scroll.tween_property(scroll, "scroll_vertical", destino, 0.2)


func _on_capturador_input_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_mover_foco(1)
			accept_event()
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_mover_foco(-1)
			accept_event()
	elif event.is_action_pressed("nav_abajo"):
		_mover_foco(1)
		accept_event()
	elif event.is_action_pressed("nav_arriba"):
		_mover_foco(-1)
		accept_event()
	elif event.is_action_pressed("nav_avanzar"):
		_confirmar_seleccion()
		accept_event()
	elif event.is_action_pressed("nav_retroceder"):
		_volver()
		accept_event()

func _volver() -> void:
	get_tree().change_scene_to_file("res://scenes/MenuPrincipal/menu_principal.tscn")

func _mover_foco(direccion: int) -> void:
	var indice_actual: int = items.find(get_viewport().gui_get_focus_owner())
	if indice_actual == -1:
		return
	var nuevo_indice: int = clamp(indice_actual + direccion, 0, items.size() - 1)
	items[nuevo_indice].grab_focus()


func _on_item_serie_pressed() -> void:
	pass # Replace with function body.

func _confirmar_seleccion() -> void:
	var indice_actual: int = items.find(get_viewport().gui_get_focus_owner())
	if indice_actual == -1:
		return
	var serie_id: String = items[indice_actual].get_meta("serie_id")
	EstadoNavegacion.serie_id = serie_id
	get_tree().change_scene_to_file("res://scenes/DetalleSerie/detalle_serie.tscn")


func _on_item_serie_2_pressed() -> void:
	pass # Replace with function body.


func _on_item_serie_3_pressed() -> void:
	pass # Replace with function body.
