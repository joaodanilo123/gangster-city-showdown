extends Node
class_name SupplyBoxContainer

signal box_destroyed()

func _ready():
	for supplyBox in get_children():
		supplyBox.tree_exited.connect(handle_child_supplyBox_destroyed)

func handle_child_supplyBox_destroyed():
	box_destroyed.emit()
