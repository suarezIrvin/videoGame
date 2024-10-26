class_name Barril
extends RigidBody2D

@export var abajo = 500
@export var fuerza_rodamiento = 1000 # Fuerza aplicada para rodar
@export var velocidad_angular = 5.0 # Velocidad angular inicial del barril
@export var incremento_velocidad = 1.0 # Factor de incremento de velocidad tras colisión

@export var material_fisico: PhysicsMaterial

func _ready() -> void:
	# Asignar el material de física con la fricción deseada
	physics_material_override = material_fisico

	# Establecer una velocidad angular inicial para que el barril comience a rodar
	angular_velocity = velocidad_angular

func _process(delta: float) -> void:
	if position.y > abajo:
		queue_free()

	# Verificar si el barril está en la posición (576, 376)
	if position == Vector2(544, 376):
		queue_free() # Eliminar el barril cuando llegue a esta posición exacta

func _physics_process(delta: float) -> void:
	# Mantener el rodamiento continuo
	angular_velocity = sign(angular_velocity) * velocidad_angular

# Este método se llama cuando el barril choca con otro objeto
func _on_Barril_body_entered(body: Node) -> void:
	# Invertir la dirección del rodamiento
	velocidad_angular = -velocidad_angular * incremento_velocidad
	# Aumentar la velocidad al cambiar de dirección
	angular_velocity = sign(angular_velocity) * velocidad_angular
	

func _on_ataque_body_entered(body: Node2D) -> void:
	if body is Player:
		body.queue_free()  # Elimina el cuerpo del jugador (o algún efecto deseado)
		
		await get_tree().create_timer(1).timeout  # Espera 1 segundo
		
		Global.coins = 0  # Reinicia el contador de monedas antes de recargar la escena
		
		get_tree().reload_current_scene()  # Recarga la e
	pass # Replace with function body.
