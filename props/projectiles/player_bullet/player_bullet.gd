extends Node2D
class_name PlayerBullet

@export var stats: ProjectileStats

var emitter: Node2D
var direction: int = 0


func _process(delta):
	position.x += direction * stats.speed * delta

func _on_area_2d_area_entered(area):
	if(area.has_method("take_damage")):
		area.take_damage(emitter, self)
	
	queue_free()
