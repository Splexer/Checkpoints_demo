extends Control

func _ready() -> void:
	Events.HUD_update.connect(_on_coin_collected)
	
func _on_coin_collected(coins: int)-> void:
	$Coins.text = str(coins)
