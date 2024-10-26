extends CharacterBody2D
class_name Player

const SPEED = 175.0
const JUMP_VELOCITY = -302.0
var door_detected = false  
var all_coins_collected = false  # Nueva variable para rastrear si todas las monedas han sido recolectadas

@onready var animation := $AnimationPlayer
@onready var sprite := $Sprite2D
@onready var coinslabel := $PlayerGUI/HBoxContainer/CoinsLabel2
@onready var level2 := "res://scene/lv_3.tscn"  # Ruta a la escena del siguiente nivel
@onready var level3 := "res://scene/lv_4.tscn" 
@onready var level4 := "res://scene/final.tscn"  # Ruta a la escena del siguiente nivel

func _ready():
	Global.player = self
	updateCoins()  # Asegúrate de mostrar el contador de monedas al inicio

func _process(_delta):
	if door_detected:
		pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Cambiar la animación en función de la dirección
	if direction != 0:
		animation.play("run")
	else:
		animation.play("idle")
	
	sprite.flip_h = direction < 0 if direction != 0 else sprite.flip_h

	move_and_slide()

# Función para actualizar el contador de monedas en el HUD
func updateCoins():
	print("update coins")
	coinslabel.text = str(Global.coins)

# Función para cambiar de nivel
func transition_to_next_level():
	Global.coins = 0  # Reiniciar el contador de monedas antes de cambiar de nivel
	get_tree().change_scene_to_file(level2)  # Cambiar a la siguiente escena
	
func transition_to_next_level_final():
	Global.coins = 0  # Reiniciar el contador de monedas antes de cambiar de nivel
	get_tree().change_scene_to_file(level3)  # Cambiar a la siguiente escena

func transition_to_next_level_finish():
	Global.coins = 0  # Reiniciar el contador de monedas antes de cambiar de nivel
	get_tree().change_scene_to_file(level4)  # Cambiar a la siguiente escena
# Player.gd
func play_dead_animation() -> void:
	$AnimationPlayer.play("dead")  # Reproduce la animación "dead"


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
