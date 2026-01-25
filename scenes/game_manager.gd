extends Node


var coins: int = 0
var gems: int = 0
var stopwatch_time: float = 0

var can_dash: bool = true
var dash_cooldown_time: float = 0


func _ready() -> void:
    RenderingServer.set_default_clear_color(Color(0.53, 0.81, 0.92))
    Engine.time_scale = 5


func _process(delta: float) -> void:
    stopwatch_time += delta
