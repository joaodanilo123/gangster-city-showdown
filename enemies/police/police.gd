extends CharacterBody2D
class_name Police

@export var SPEED : int = 100
@export var RUN_MULTIPLIER : int = 2
@export var JUMP_FORCE : int = 500
@export var GRAVITY : int = 900
@export var max_health: int = 300
@export var facing_direction = 1

@onready var health : int = max_health
@onready var gun_barrel = $GunBarrel
@onready var gun_cadence_timer = $GunCadenceTimer
@onready var sprites = $Sprites
@onready var can_shoot = true
@onready var bullet: PackedScene = preload("res://props/projectiles/police_bullet/police_bullet.tscn")
@onready var detection_range = %DetectionRange

var player_detected = false

func _physics_process(delta):
	if(health <= 0):
		die()
		return
	
	handle_movement(delta)
	handle_gun()


func handle_movement(delta):
	
	var relative_position = 0
	
	if Global.player != null:
		relative_position = position.x - Global.player.position.x 
	
	var direction = 0
	
	if player_detected:
		if relative_position > 0:
			direction = -1
		else:
			direction = 1
	
	if direction and abs(relative_position) > 400:
		facing_direction = direction
		velocity.x = SPEED * direction
		if is_on_floor():
			if abs(relative_position) > 500:
				sprites.play("run")
				velocity.x *= RUN_MULTIPLIER
			else:
				sprites.play("walking")
	else:
		velocity.x = 0
		if is_on_floor() and can_shoot:
			sprites.play("idle2")
			
	sprites.flip_h = (facing_direction == -1) 
	gun_barrel.position.x = abs(gun_barrel.position.x) * facing_direction
	detection_range.target_position.x = abs(detection_range.target_position.x) * facing_direction
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y > 0:
			sprites.play("fall")
	
	move_and_slide()

func handle_gun():
	if detection_range.is_colliding() and can_shoot:
		var body = detection_range.get_collider()
		if body.is_in_group("player"):
			player_detected = true
			sprites.play("shoot")
			gun_cadence_timer.start()
			can_shoot = false
			
			var bullet_instance: PoliceBullet = bullet.instantiate()
			bullet_instance.global_position = gun_barrel.global_position
			bullet_instance.direction = facing_direction
			bullet_instance.emitter = self
			Global.main_scene.add_child(bullet_instance)

func take_damage(emitter, projectileStats: ProjectileStats):
	if(emitter.is_in_group("player")):
		health -= projectileStats.damage

func die():
	sprites.play("death")
	await get_tree().create_timer(sprites.get_playing_speed()).timeout
	queue_free()

func _on_gun_cadence_timer_timeout():
	can_shoot = true
