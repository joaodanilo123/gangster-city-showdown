extends CharacterBody2D

@export var SPEED : int = 150
@export var JUMP_FORCE : int = 500
@export var GRAVITY : int = 900

@onready var sprites = $Sprites
@onready var facing_direction = 1

func _physics_process(delta):
	handle_movement(delta)
	

func handle_movement(delta):
	var direction = Input.get_axis("move_left","move_right")
	
	if direction:
		facing_direction = direction
		velocity.x = SPEED * direction
		if is_on_floor():
			sprites.play("run")
	else:
		velocity.x = 0
		if is_on_floor():
			sprites.play("idle")
	
	sprites.flip_h = (facing_direction == -1) 

	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y > 0:
			sprites.play("fall")
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y -= JUMP_FORCE
			sprites.play("jump")
	move_and_slide()
	
