extends Area2D

# Referencia al AnimationPlayer
@onready var animation_player = $AnimationPlayer

# Inicia la animación cuando la moneda esté lista
func _ready():
	animation_player.play("coin")  # Asegúrate de que la animación se llame "coin"
	Global.connect("level_reset", Callable(self, "_on_Global_level_reset"))

# Detecta cuando el jugador entra en contacto con la moneda
func _on_body_entered(body):
	if body is Player:
		Global.coins += 1  # Incrementa el contador global de monedas
		print(Global.coins)
		queue_free()  # Elimina la moneda una vez recogida

# Resetea el contador de monedas cuando el nivel se reinicia
func _on_Global_level_reset():
	Global.coins = 0  # Reinicia el contador de monedas

# Función para reiniciar la escena y reiniciar el contador
func reload_scene():
	Global.coins = 0  # Reinicia el contador cuando la escena se recarga
	get_tree().reload_current_scene()  # Recarga la escena actual
