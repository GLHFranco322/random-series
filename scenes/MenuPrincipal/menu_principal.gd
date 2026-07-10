extends Control

func _on_boton_continuar_pressed() -> void:
	pass # Placeholder: todavía no existe el sistema de historial

func _on_boton_seleccionar_serie_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/SeleccionarSerie/seleccionar_sarie.tscn")

func _on_boton_series_random_pressed() -> void:
	EstadoNavegacion.pedir_random_global()
	get_tree().change_scene_to_file("res://scenes/Player/player.tscn")
