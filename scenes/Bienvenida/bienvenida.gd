extends Control

func _on_boton_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MenuPrincipal/menu_principal.tscn")
