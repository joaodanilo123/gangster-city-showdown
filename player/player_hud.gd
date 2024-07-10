extends CanvasLayer

@onready var healthBar = $HealthBar
@onready var healthBarText = $HealthBar/Label
@onready var money_label = $PanelContainer/HBoxContainer/MoneyLabel

func _ready():
	Global.money_received.connect(change_money_label)
	change_money_label(Global.money)
	
	Global.player.health_changed.connect(_on_player_health_changed)
	handle_health_bar(Global.player.max_health, Global.player.max_health)
	healthBar.max_value = Global.player.max_health
	
	
func handle_health_bar(health: float, max_health: float):
	const health_bar_label_format = "%d / %d"
	healthBar.value = health
	healthBarText.text = health_bar_label_format % [health, max_health]


func _on_player_health_changed(current_health):
	handle_health_bar(current_health, Global.player.max_health)

func change_money_label(amount):
	money_label.text = str(Global.money)

