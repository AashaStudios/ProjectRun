extends Node


var coins: int = 0
var gems: int = 0


func _ready() -> void:
    RenderingServer.set_default_clear_color(Color(0.53, 0.81, 0.92))
