extends RigidBody2D
class_name SupplyBox

@export var health = 200

func _process(delta):
	if(health <= 0):
		die()

func take_damage(emitter, projectileStats: ProjectileStats):
	if(emitter.is_in_group("player")):
		health -= projectileStats.damage

func die():
	queue_free()
