extends Node
# Autoload: EstadoNavegacion
# Guarda qué se le pide al Player antes de cambiar de escena.

enum Modo {
	MANUAL,          # capítulo elegido a mano
	RANDOM_GLOBAL,    # random entre todas las series
	RANDOM_SERIE,     # random dentro de una serie puntual
	RANDOM_TEMPORADA, # arranca en el ep 1 de una temporada elegida
	CONTINUAR         # retoma el último capítulo visto
}

var modo: Modo = Modo.RANDOM_GLOBAL
var serie_id: String = ""
var temporada_num: int = -1
var episodio_num: int = -1

func pedir_random_global() -> void:
	modo = Modo.RANDOM_GLOBAL
	serie_id = ""
	temporada_num = -1
	episodio_num = -1

func pedir_random_serie(id_serie: String) -> void:
	modo = Modo.RANDOM_SERIE
	serie_id = id_serie
	temporada_num = -1
	episodio_num = -1

func pedir_random_temporada(id_serie: String, num_temporada: int) -> void:
	modo = Modo.RANDOM_TEMPORADA
	serie_id = id_serie
	temporada_num = num_temporada
	episodio_num = -1

func pedir_capitulo_manual(id_serie: String, num_temporada: int, num_episodio: int) -> void:
	modo = Modo.MANUAL
	serie_id
