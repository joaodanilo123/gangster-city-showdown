extends Area2D
class_name ArmouredCar

@export var max_health: int = 1000
@onready var health: int = max_health
@onready var money_up_effect = $MoneyUpEffect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(health <= 0):
		die()

func take_damage(emitter, projectileStats: ProjectileStats):
	if(emitter.is_in_group("player")):
		health -= projectileStats.damage
		Global.give_money(projectileStats.damage)
		money_up_effect.play()

func die():
	queue_free()
