extends Node2D
class_name BossBullet

@export var stats: ProjectileStats

var emitter: Node2D
var direction: int = 0


func _process(delta):
	position.x += direction * stats.speed * delta

func _on_area_2d_body_entered(body):
	if(body.has_method("take_damage") and body.is_in_group("player")):
		body.take_damage(emitter, stats)
		queue_free()
	
