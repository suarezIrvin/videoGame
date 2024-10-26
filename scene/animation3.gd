extends AnimationPlayer

func _ready():
	# Reproducir la animación del boss
	play("jump3")
 # Llama directamente a play() porque ya extiendes AnimationPlayer
