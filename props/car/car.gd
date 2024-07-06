extends Node2D
class_name Car

var on_interaction_zone = false

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if on_interaction_zone and Global.objective_completed:
			print("interagiu")
			Global.complete_level()
	
func _on_interaction_zone_body_entered(body):
	if body.is_in_group("player"):
		print("on interaction zone")
		on_interaction_zone = true

func _on_interaction_zone_body_exited(body):
	if body.is_in_group("player"):
		print("out of interaction zone")
		on_interaction_zone = false
