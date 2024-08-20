class_name movimientoSuave
extends CharacterBody2D

@export var gravity=100
@export var velocity_jump=100
@export var speed=100

func _physics_process(delta):
	
	#horizontal
	var direccion = Input.get_axis("izquierda","derecha")
	velocity.x = speed * direccion
	
	#gravedad
	if not is_on_floor():
		velocity.y = velocity.y + gravity * delta
	
	#saltar 
	var salto = Input.is_action_just_pressed("arriba")
	if salto:
		velocity.y = velocity.y - velocity_jump
	
	
	move_and_slide()
