extends Control


@onready var game_manager: Node = %GameManager
@onready var coin_count_label: Label = $Coins/CoinCountLabel
@onready var gem_count_label: Label = $Gems/GemCountLabel
@onready var stopwatch_label: Label = $StopwatchLabel
@onready var dash_cooldown_label: Label = $DashCooldown/DashCooldownLabel


func _process(_delta: float) -> void:
    coin_count_label.text = "x" + str(game_manager.coins)
    gem_count_label.text = "x" + str(game_manager.gems)
    
    update_time(game_manager.stopwatch_time)
    update_dash_cooldown()


func update_time(time_in_seconds: float) -> void:
    var minutes: int = int(time_in_seconds / 60) % 60
    var seconds: int = int(time_in_seconds) % 60
    var milliseconds: int = int(time_in_seconds * 1000.0) % 1000
    
    stopwatch_label.text = "%02d:%02d.%01d" % [minutes, seconds, milliseconds]


func update_dash_cooldown() -> void:
    if game_manager.can_dash:
        dash_cooldown_label.hide()
    else:
        dash_cooldown_label.show()
        dash_cooldown_label.text = "%.1f" % game_manager.dash_cooldown_time
