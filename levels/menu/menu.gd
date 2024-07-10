extends Control

@onready var label_level_title = $HBoxContainer/VBoxContainer/PanelContainer/LabelLevelTitle
@onready var label_level_description = $HBoxContainer/VBoxContainer/LabelLevelDescription
@onready var texture_rect_map = $HBoxContainer/TextureRectMap

@onready var button_level_1 = $HBoxContainer/TextureRectMap/ButtonLevel1
@onready var button_level_2 = $HBoxContainer/TextureRectMap/ButtonLevel2
@onready var button_level_3 = $HBoxContainer/TextureRectMap/ButtonLevel3


func _ready():
	label_level_title.text = ""
	label_level_description.text = ""
	
	if Global.level >= 1:
		button_level_1.disabled = false
	if Global.level >= 2:
		button_level_2.disabled = false
	if Global.level >= 3:
		button_level_3.disabled = false
	
	for mapButton in texture_rect_map.get_children():
		mapButton.hovered_level.connect(change_level_data)
		
func change_level_data(level: Level):
	label_level_title.text = level.title
	label_level_description.text = level.description
