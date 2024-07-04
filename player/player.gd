extends CharacterBody2D

@export var speed = 600.0
@export var jump_speed = -600.0
@export var can_bounce = true
@export var health = 500

@onready var facing_direction = 1
@onready var can_shoot = true
@onready var jumps: int = 0
@onready var bounce_force: Vector2 = Vector2(0, 0)

@onready var sprites = $Sprites


const CAMERA_OFFSET_MOVEMENT = 0.8
const CAMERA_OFFSET_STILL = 0.5

signal health_changed(current_health: float)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var jumping = false
var shooting = false
var idle = true
var running = false

func _physics_process(delta):
	if(health <= 0):
		die()
	
	handle_movement(delta)
	handle_gun()
	handle_animation()
	move_and_slide()

func handle_movement(delta):
	
	sprites.flip_h = (facing_direction == -1)
	
	#(esquerda: -1, direita: 1, sem movimento: 0)
	var direction = Input.get_axis("move_left", "move_right") 
	if direction:
		facing_direction = direction
		#camera.drag_horizontal_offset = CAMERA_OFFSET_MOVEMENT * facing_direction
		if is_on_floor():
			running = true
		else:
			running = false
			
		if bounce_force.x == 0:
			velocity.x = facing_direction * speed
	else:
		#camera.drag_horizontal_offset = CAMERA_OFFSET_STILL * facing_direction
		if is_on_floor():
			idle = true
			velocity.x = move_toward(velocity.x, 0 , speed)
		else:
			idle = false
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
		jumping = true
	else:
		jumping = false
	
	velocity.y += gravity * delta
	velocity += bounce_force
	bounce_force = Vector2(move_toward(bounce_force.x, 0, speed), 0)
	
func handle_gun():
	if Input.is_action_pressed("shoot"):
		shoot()
	else:
		shooting = false

func handle_animation():
	if idle:
		sprites.play("idle")
	elif jumping:
		sprites.play("jump")
	elif running:
		sprites.play("run")
	elif shooting:
		sprites.play("shoot")
	
		
func shoot():
	if(!can_shoot):
		return
	else:
		shooting = true

func bounce(force: Vector2):
	if can_bounce:
		bounce_force = force
	
func take_damage(damage):
	health -= damage
	health_changed.emit(health)

func die():
	#can_shoot = false
	#sprites_wrapper.visible = false
	#explosion_particles.explode()
	#await get_tree().create_timer(explosion_particles.lifetime).timeout
	#var death_screen: PackedScene = load("res://Interfaces/Menus/death_screen.tscn")
	#get_tree().change_scene_to_packed(death_screen)
	#queue_free()
	pass

func _on_gun_cadence_timer_timeout():
	can_shoot = true
