extends Node
class_name Main

@export var level_resource: Level

var level_scene_instance: Node = null

func _ready():
	Global.main_scene = self
	load_level(level_resource)
	
func unload_level():
	if is_instance_valid(level_scene_instance):
		level_scene_instance.queue_free()
	level_resource = null
	level_scene_instance = null
	
func load_level(new_level: Level):
	unload_level()
	var new_level_scene: PackedScene = load(new_level.scene_path)
	if(new_level_scene):
		Global.objective_completed = false
		level_scene_instance = new_level_scene.instantiate()
		add_child(level_scene_instance)
