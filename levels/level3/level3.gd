extends Node2D
class_name Level3



func _on_boss_tree_exited():
	Global.objective_completed = true
	Global.complete_level()
