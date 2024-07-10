extends Node

var main_scene: Main
var player: Player
var money = 0
var level = 1

@onready var objective_completed = false
@onready var menu_level: Level = ResourceLoader.load("res://levels/menu/menu_level.tres", "Level")

signal money_received(amount: int)

func give_money(amount: int):
	money += amount
	money_received.emit(amount)

func change_level(level: Level):
	main_scene.load_level(level)
	
func complete_level():
	if(objective_completed):
		level+=1
	main_scene.load_level(menu_level)
