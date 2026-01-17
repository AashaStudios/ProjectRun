extends CharacterBody2D


const MAX_SPEED: int = 200
const ACCELERATION: int = 17
const FRICTION: int = 20
const JUMP_VELOCITY: int = -275

var coyote_time_activated: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer


func _physics_process(delta: float) -> void:
    # Jump Code
    if is_on_floor():
        coyote_time_activated = false
    else:
        if coyote_timer.is_stopped() and !coyote_time_activated:
            coyote_timer.start()
            print(coyote_timer.time_left)
            coyote_time_activated = true
        
        if Input.is_action_just_released("jump") or is_on_ceiling():
            velocity.y *= 0.5
    
    if Input.is_action_pressed("jump"):
        if jump_buffer_timer.is_stopped():
            jump_buffer_timer.start()
    
    if !jump_buffer_timer.is_stopped() and (!coyote_timer.is_stopped() or is_on_floor()):
        velocity.y = JUMP_VELOCITY
        jump_buffer_timer.stop()
        coyote_timer.stop()
        coyote_time_activated = true

    # Gravity Code
    if not is_on_floor():
        velocity += get_gravity() * delta

    # Running Code
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
