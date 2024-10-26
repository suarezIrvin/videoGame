class_name Boss
extends Node2D

@onready var animation_player = $AnimatedSprite2D
const BARRIL = preload("res://finalBoss/barril.tscn")
@onready var timer = Timer.new()  # Crear un nuevo Timer

func _ready():
	# Reproducir la animación del boss
	animation_player.play("boss") 
	
	# Conectar la señal animation_finished a la función on_animation_finished
	animation_player.connect("animation_finished", Callable(self, "on_animation_finished"))

	# Configurar el Timer
	timer.wait_time = 6.5  # Esperar 3 segundos
	timer.one_shot = false  # Hacer que el Timer se repita
	add_child(timer)  # Añadir el Timer como hijo del Boss
	timer.connect("timeout", Callable(self, "launch_barrel"))  # Conectar la señal timeout al método launch_barrel
	timer.start()  # Iniciar el Timer

func on_animation_finished():
	# Llamar a launch_barrel cuando la animación termine
	launch_barrel()

	# Reproducir nuevamente la animación del boss si deseas un ciclo continuo
	animation_player.play("boss") 

func launch_barrel():
	# Instanciar un nuevo barril
	var instancia_barril = BARRIL.instantiate()
	
	# Posicionar el barril en la misma posición que el Boss
	instancia_barril.position = Vector2(144, 63)
	
	# Añadir el barril a la escena
	get_parent().add_child(instancia_barril)
