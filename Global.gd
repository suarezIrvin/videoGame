extends Node

var total_coins = 10
var coins = 0:
	
	set(val):
		coins = val
		if player != null:
			player.updateCoins()
			$coinsSound.play()
		if coins >= total_coins:  # Comprobar si se han recolectado todas las monedas
			player.all_coins_collected = true  # Activar la variable en el jugador
	get:
		return coins

var player
