extends Area2D

func _ready() -> void:
	# Conectar la señal 'body_entered' con el método '_on_body_entered'
	self.body_entered.connect(_on_body_entered)

# Este método se llama cuando un cuerpo entra en el área
func _on_body_entered(body: Node) -> void:
	# Verificar si el cuerpo que entró es un Barril
	if body is Barril:
		body.queue_free()  # Eliminar el barril
