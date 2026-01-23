extends Control


@onready var game_manager: Node = %GameManager
@onready var coin_count_label: Label = $Coins/CoinCountLabel
@onready var gem_count_label: Label = $Gems/GemCountLabel
@onready var stopwatch_label: Label = $StopwatchLabel


func _process(_delta: float) -> void:
    coin_count_label.text = "x" + str(game_manager.coins)
    gem_count_label.text = "x" + str(game_manager.gems)
    
    update_time(game_manager.stopwatch_time)


func update_time(time_in_seconds: float) -> void:
    var minutes: int = int(time_in_seconds / 60) % 60
    var seconds: int = int(time_in_seconds) % 60
    var milliseconds: int = int(time_in_seconds * 1000.0) % 1000
    
    stopwatch_label.text = "%02d:%02d.%01d" % [minutes, seconds, milliseconds]
