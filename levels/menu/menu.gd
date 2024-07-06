extends Control

@onready var label_level_title = $HBoxContainer/VBoxContainer/PanelContainer/LabelLevelTitle
@onready var label_level_description = $HBoxContainer/VBoxContainer/LabelLevelDescription
@onready var texture_rect_map = $HBoxContainer/TextureRectMap

func _ready():
	label_level_title.text = ""
	label_level_description.text = ""
	
	for mapButton in texture_rect_map.get_children():
		mapButton.hovered_level.connect(change_level_data)
		
func change_level_data(level: Level):
	label_level_title.text = level.title
	label_level_description.text = level.description
