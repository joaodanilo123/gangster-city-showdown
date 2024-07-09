extends Node2D
class_name MoneyUpEffect

@onready var animation_player = $AnimationPlayer

func play():
	animation_player.play("money_up")
