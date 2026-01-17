extends Node2D


const SPEED: int = 50
var direction: int = 1


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft


func _process(delta: float) -> void:
    if ray_cast_left.is_colliding():
        direction = 1
        sprite.flip_h = false
        
    if ray_cast_right.is_colliding():
        direction = -1
        sprite.flip_h = true
        
    position.x += direction * SPEED * delta
