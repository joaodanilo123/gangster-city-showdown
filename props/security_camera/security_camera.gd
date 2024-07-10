extends Node2D
class_name SecurityCamera

@export var rotate: bool = false
@export var rotation_time: float = 3

@onready var rotation_timer = %RotationTimer

func _ready():
	rotation_timer.wait_time = rotation_time

func _on_detection_area_body_entered(body):
	if(body.is_in_group("player")):
		body.health = 0

func _on_rotation_timer_timeout():
	if(rotate):
		scale.x = (-scale.x)
