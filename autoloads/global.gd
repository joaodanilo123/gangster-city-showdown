extends Node

var main_scene: Main
var player: Player
var money = 0

@onready var objective_completed = false
@onready var menu_level: Level = ResourceLoader.load("res://levels/menu/menu_level.tres", "Level")

func change_level(level: Level):
	main_scene.load_level(level)
	
func complete_level():
	main_scene.load_level(menu_level)
