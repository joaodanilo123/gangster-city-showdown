extends Node

var level_instance: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.main_scene = self

func unload_level():
	if is_instance_valid(level_instance):
		level_instance.queue_free()
	level_instance = null
	
func load_level(level_scene: String):
	unload_level()
	var level_res: PackedScene = load(level_scene)
	if(level_res):
		level_instance = level_res.instantiate()
		add_child(level_instance)
