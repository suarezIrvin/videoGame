extends Area2D

@onready var timer := $Timer
@onready var collision := $CollisionShape2D
@onready var animation := $AnimationPlayer
@onready var warning_label := $Label

func _ready():
	# Asegúrate de que el Label esté en el frente sobre las imágenes
	warning_label.set_z_index(100)  # Un número alto para que esté al frente
	warning_label.z_as_relative = true  # Asegura que se use z_index relativo
	warning_label.visible = false  # Inicialmente oculto

func _on_body_entered(body):
	if body is Player and body.all_coins_collected:  # Verificar si el jugador recolectó todas las monedas
		body.door_detected = true
		animation.play("open")
		collision.queue_free()  # Desactivar la colisión si es necesario
		timer.start()  # Iniciar el temporizador
		$openDoor.play()
		await timer.timeout  # Esperar a que el temporizador termine
		body.transition_to_next_level_finish()  # Cambiar de nivel después de la animación
	else:
		# Mostrar el mensaje de advertencia
		warning_label.text = "Aún faltan monedas \n por recolectar"
		warning_label.visible = true  # Hacer visible el Label
		await get_tree().create_timer(2.0).timeout  # Esperar 2 segundos
		warning_label.visible = false  # Ocultar el Label después de 2 segundos
