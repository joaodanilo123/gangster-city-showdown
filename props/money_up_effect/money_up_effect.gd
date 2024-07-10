extends Node2D
class_name MoneyUpEffect

@onready var animation_player = $AnimationPlayer

func play():
	animation_player.play("money_up")

func _on_animation_player_animation_finished(_anim_name):
	animation_player.play("RESET")
