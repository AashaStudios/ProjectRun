extends CharacterBody2D


const MAX_SPEED: int = 200
const ACCELERATION: int = 15
const FRICTION: int = 12
const JUMP_VELOCITY: int = -250

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer


func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity += get_gravity() * delta

    if Input.is_action_pressed("jump") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    var direction: float = Input.get_axis("left", "right")
    var velocity_weight: float = delta * (ACCELERATION if direction else FRICTION)
    
    velocity.x = lerp(velocity.x, direction * MAX_SPEED, velocity_weight)
    
    if direction > 0:
        sprite.flip_h = false
    elif direction < 0:
        sprite.flip_h = true
    
    if is_on_floor():
        if not direction:
            sprite.play("idle")
        else:
            sprite.play("run")
    else:
        sprite.play("jump")

    move_and_slide()
