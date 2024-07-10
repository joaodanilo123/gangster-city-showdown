extends CanvasLayer
class_name ObjectiveHud

@onready var label = $PanelContainer/HBoxContainer/Label
@onready var level2 = get_parent()
const label_format = "%d / %d"

func change_label(completed: float, necessary: float):
	label.text = label_format % [completed, necessary]
