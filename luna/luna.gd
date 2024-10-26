extends Area2D


# Detecta cuando el jugador entra en contacto con la moneda
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.queue_free()  # Elimina el cuerpo del jugador (o algún efecto deseado)
		
		await get_tree().create_timer(1).timeout  # Espera 1 segundo
		
		Global.coins = 0  # Reinicia el contador de monedas antes de recargar la escena
		
		get_tree().reload_current_scene()  # Recarga la escena actual
