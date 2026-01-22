extends Control


@onready var game_manager: Node = %GameManager
@onready var coin_count_label: Label = $Coins/CoinCountLabel
@onready var gem_count_label: Label = $Gems/GemCountLabel


func _process(_delta: float) -> void:
    coin_count_label.text = "x " + str(game_manager.coins)
    gem_count_label.text = "x " + str(game_manager.gems)
