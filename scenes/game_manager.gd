extends Node


@onready var coin_count_label: Label = %CoinCountLabel
@onready var gem_count_label: Label = %GemCountLabel


var coins: int = 0
var gems: int = 0


func _ready() -> void:
    RenderingServer.set_default_clear_color(Color(0.53, 0.81, 0.92))
