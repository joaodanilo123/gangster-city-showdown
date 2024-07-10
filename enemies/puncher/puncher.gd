extends CharacterBody2D
class_name Puncher

@export var SPEED : int = 200
@export var RUN_MULTIPLIER : int = 1.2
@export var JUMP_FORCE : int = 500
@export var GRAVITY : int = 900
@export var max_health: int = 500
@export var facing_direction = 1
@export var punch_stats: ProjectileStats

@onready var health : int = max_health
@onready var gun_barrel = $GunBarrel
@onready var gun_cadence_timer = $GunCadenceTimer
@onready var sprites = $Sprites
@onready var can_attack = true
@onready var detection_range = %DetectionRange
@onready var punch_range = %PunchRange



var player_detected = false

func _physics_process(delta):
	if(health <= 0):
		die()
		return
	
	handle_movement(delta)
	handle_attack()


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
	
	if direction and abs(relative_position) > 36:
		facing_direction = direction
		velocity.x = SPEED * direction
		if is_on_floor():
			if abs(relative_position) > 500:
				sprites.play("walking")
			else:
				sprites.play("run")
				velocity.x *= RUN_MULTIPLIER
	else:
		velocity.x = 0
		if is_on_floor() and can_attack:
			sprites.play("idle")
			
	sprites.flip_h = (facing_direction == -1) 
	gun_barrel.position.x = abs(gun_barrel.position.x) * facing_direction
	detection_range.target_position.x = abs(detection_range.target_position.x) * facing_direction
	punch_range.target_position.x = abs(punch_range.target_position.x) * facing_direction
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y > 0:
			sprites.play("fall")
	
	move_and_slide()

func handle_attack():
	if detection_range.is_colliding():
		if detection_range.get_collider() != null and detection_range.get_collider().is_in_group("player"):
			player_detected = true
	
	if punch_range.is_colliding():
		var body = punch_range.get_collider()
		if body != null and body.is_in_group("player"):
			if(can_attack):
				body.take_damage(self, punch_stats)
				gun_cadence_timer.start()
				can_attack = false
			sprites.play("attack01")

func take_damage(emitter, projectileStats: ProjectileStats):
	if(emitter.is_in_group("player")):
		health -= projectileStats.damage

func die():
	sprites.play("death")
	await get_tree().create_timer(sprites.get_playing_speed()).timeout
	queue_free()

func _on_gun_cadence_timer_timeout():
	can_attack = true
