extends Area2D
class_name ArmouredCar

@export var health: int = 1000
@onready var money_up_effect = $MoneyUpEffect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func take_damage(emitter, source):
	money_up_effect.play()
	pass
