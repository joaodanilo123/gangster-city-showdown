extends Button
class_name MapButton

@export var level: Level

signal hovered_level(level: Level)

func _on_pressed():
	Global.change_level(level)

func _on_mouse_entered():
	hovered_level.emit(level)
