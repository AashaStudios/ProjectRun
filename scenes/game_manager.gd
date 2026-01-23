extends Node


var coins: int = 0
var gems: int = 0
var stopwatch_time: float = 0


func _ready() -> void:
    RenderingServer.set_default_clear_color(Color(0.53, 0.81, 0.92))


func _process(delta: float) -> void:
    stopwatch_time += delta
