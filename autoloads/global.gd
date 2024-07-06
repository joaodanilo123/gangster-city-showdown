extends Node

var main_scene: Main
var player: Player

func change_level(level: Level):
	main_scene.load_level(level)
