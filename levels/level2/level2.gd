extends Node2D
class_name Level2

@export var box_to_objetive = 10
var destroyed_boxes = 0

@onready var supply_box_container = %SupplyBoxContainer
@onready var objective_hud = %ObjectiveHud

func _ready():
	supply_box_container.box_destroyed.connect(handle_box_destroyed)

func handle_box_destroyed():
	destroyed_boxes += 1
	objective_hud.change_label(destroyed_boxes, box_to_objetive)
	if destroyed_boxes >= box_to_objetive:
		Global.objective_completed = true

