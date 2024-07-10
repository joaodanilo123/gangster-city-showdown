extends CharacterBody2D
class_name Player

@export var SPEED : int = 150
@export var RUN_MULTIPLIER : int = 2
@export var JUMP_FORCE : int = 500
@export var GRAVITY : int = 900
@export var max_health: int = 1000

@onready var health : int = max_health
@onready var gun_barrel = $GunBarrel
@onready var gun_cadence_timer = $GunCadenceTimer
@onready var sprites = $Sprites
@onready var facing_direction = 1
@onready var can_shoot = true
@onready var bullet: PackedScene = preload("res://props/projectiles/player_bullet/player_bullet.tscn")
@onready var hud: PackedScene = preload("res://player/player_hud.tscn")

signal health_changed(new_health)

func _ready():
	Global.player = self
	var hud_instance = hud.instantiate()
	add_child(hud_instance)

func _physics_process(delta):
	if(health <= 0):
		die()
		return
	
	handle_movement(delta)
	handle_gun()


func handle_movement(delta):
	var direction = Input.get_axis("move_left","move_right")
	
	if direction:
		facing_direction = direction
		velocity.x = SPEED * direction
		if is_on_floor():
			if Input.is_action_pressed("run"):
				sprites.play("run")
				velocity.x *= RUN_MULTIPLIER
			else:
				sprites.play("walking")
	else:
		velocity.x = 0
		if is_on_floor() and can_shoot:
			sprites.play("idle")
			
	sprites.flip_h = (facing_direction == -1) 
	gun_barrel.position.x = abs(gun_barrel.position.x) * facing_direction
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y > 0:
			sprites.play("fall")
	
	if is_on_floor():
		if Input.is_action_just_pressed("move_up"):
			velocity.y -= JUMP_FORCE
			sprites.play("jump")
	move_and_slide()

func handle_gun():
	if Input.is_action_pressed("shoot") and can_shoot:
		sprites.play("shoot")
		gun_cadence_timer.start()
		can_shoot = false
		
		var bullet_instance: PlayerBullet = bullet.instantiate()
		bullet_instance.global_position = gun_barrel.global_position
		bullet_instance.direction = facing_direction
		bullet_instance.emitter = self
		Global.main_scene.add_child(bullet_instance)

func take_damage(emitter, projectileStats: ProjectileStats):
	if(emitter.is_in_group("enemy")):
		health -= projectileStats.damage
		health_changed.emit(health)

func die():
	sprites.play("death")
	await get_tree().create_timer(sprites.get_playing_speed()).timeout
	queue_free()

func _on_gun_cadence_timer_timeout():
	can_shoot = true
