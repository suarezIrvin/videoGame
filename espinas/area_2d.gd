extends Area2D

# Variable para controlar si la escena ya está en proceso de reinicio
var scene_reloading: bool = false

# Referencia al Timer
@onready var timer: Timer = Timer.new()

# Detecta cuando el jugador entra en contacto con la moneda o cualquier objeto
func _ready() -> void:
	# Agregar el Timer al nodo
	add_child(timer)
	timer.wait_time = 1.0  # Establece el tiempo de espera en 1 segundo
	timer.one_shot = true  # Asegúrate de que solo se ejecute una vez
	timer.timeout.connect(_on_timer_timeout)  # Conectar la señal timeout

func _on_body_entered(body: Node2D) -> void:
	# Solo procede si el cuerpo es el jugador y aún no se está recargando la escena
	if body is Player and not scene_reloading:
		scene_reloading = true  # Marca que el proceso de reinicio ha comenzado
		
		body.queue_free()  # Elimina el cuerpo del jugador (o realiza alguna acción)

		timer.start()  # Inicia el temporizador

# Método que se llama cuando el temporizador se agota
func _on_timer_timeout() -> void:
	Global.coins = 0  # Reinicia el contador de monedas antes de recargar la escena
	get_tree().reload_current_scene()  # Recarga la escena actual
