extends CharacterBody2D

const SLIME_SPEED = 70
const GRAVITY = 78


func _ready():
	velocity.x = -SLIME_SPEED
	$AnimatedSprite2D.play("slime")
	
func _physics_process(delta):
	velocity.y += GRAVITY  
	
	# Si el enemigo choca con una pared, invierte su dirección
	if is_on_wall():
		velocity.x = -velocity.x
	
	# Volteamos el sprite dependiendo de la dirección del enemigo
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	
	# Mueve el enemigo usando la velocidad
	move_and_slide()




func _on_atac_body_entered(body: Node2D) -> void:
	if body is Player:
		body.queue_free()
		await get_tree().create_timer(1).timeout
		Global.coins = 0 
		get_tree().reload_current_scene()
