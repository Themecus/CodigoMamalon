class_name movimientoBasico
extends CharacterBody2D


@export var speed = 8000  # Velocidad en píxeles por segundo
@export var turbo=1
@export var contadorTurbo=5


var totalMonedas=0
var guardadoMonedas=0
signal enviarInformacion(totalMonedas)
signal moverSala()


func inputsMovimiento(delta):
	var horizontal=Input.get_axis("arriba","abajo")
	var vertical=Input.get_axis("izquierda","derecha")
	
	if horizontal==1:
		velocity.y=speed*delta
		
	else: if  horizontal==-1:
		velocity.y=-speed*delta
		
	else: if  vertical==1:
		velocity.x=speed*delta
		
	else: if  vertical==-1:
		velocity.x=-speed*delta
		
	else:
		velocity.x=delta
		velocity.y=delta
	
	
func inputTurbo(delta):
	if Input.is_action_just_pressed("turbo"):
		turbo=10
	
	if turbo==10:
		contadorTurbo-=1
		if contadorTurbo==0:
			turbo=1
			contadorTurbo=5
	return turbo
	
	
func inputMovmiento2(delta):
	var input_direction = Input.get_vector("izquierda", "derecha", "arriba", "abajo")
	turbo=inputTurbo(delta)
	velocity = input_direction * speed * delta * turbo
	
	
func _on_moneda_body_entered(body):
	totalMonedas=totalMonedas+1
	print(totalMonedas)
	enviarInformacion.emit(totalMonedas)
	if totalMonedas==10:
		get_tree().change_scene_to_file("res://extras/menu.tscn")
		
func _physics_process(delta):
	#inputsMovimiento(delta)
	inputMovmiento2(delta)
	move_and_slide()

func _on_puerta_1_body_entered(body):
	if body.is_in_group("jugador"):
		guardadoMonedas=totalMonedas
		get_tree().change_scene_to_file("res://niveles/nivel_2.tscn")
	
func _on_puerta_2_body_entered(body):
	if body.is_in_group("jugador"):
		guardadoMonedas=totalMonedas
		get_tree().change_scene_to_file("res://niveles/nivel_2.tscn")

func _on_puerta_3_body_entered(body):
	if body.is_in_group("jugador"):
		guardadoMonedas=totalMonedas
		get_tree().change_scene_to_file("res://niveles/nivel1.tscn")
