extends CharacterBody2D


const MAX_SPEED: int = 200
const ACCELERATION: int = 17
const FRICTION: int = 20
const JUMP_VELOCITY: int = -250
const DASH_VELOCITY: int = 600

var coyote_time_activated: bool = false
var dashing: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_timer: Timer = $Timers/CoyoteTimer
@onready var jump_buffer_timer: Timer = $Timers/JumpBufferTimer
@onready var dash_timer: Timer = $Timers/DashTimer
@onready var dash_cooltime_timer: Timer = $Timers/DashCooltimeTimer


func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity += get_gravity() * delta
    
    handle_dash()
    
    if dashing:
        return
    
    var direction: float = Input.get_axis("left", "right")
    
    handle_running(delta, direction)
    handle_dash()
    handle_jump()
    handle_animation(direction)

    move_and_slide()


func handle_running(delta: float, direction: float) -> void:
    var velocity_weight: float = delta * (ACCELERATION if direction else FRICTION)
    velocity.x = lerp(velocity.x, direction * MAX_SPEED, velocity_weight)


func handle_dash() -> void:
    if Input.is_action_just_pressed("dash") and dash_cooltime_timer.is_stopped():
        dash_timer.start()
        dash_cooltime_timer.start()
    
    if not dash_timer.is_stopped():
        velocity.y = 0
        sprite.play("dash")
        dashing = true
        if sprite.flip_h == false:
            velocity.x = DASH_VELOCITY
        else:
            velocity.x = -DASH_VELOCITY
        
        move_and_slide()
    
    if dash_timer.is_stopped():
        dashing = false


func handle_jump() -> void:
    if is_on_floor():
        coyote_time_activated = false
    else:
        if coyote_timer.is_stopped() and !coyote_time_activated:
            coyote_timer.start()
            coyote_time_activated = true
        
        if Input.is_action_just_released("jump") or is_on_ceiling():
            velocity.y *= 0.25
    
    if Input.is_action_just_pressed("jump"):
        if jump_buffer_timer.is_stopped():
            jump_buffer_timer.start()
    
    if !jump_buffer_timer.is_stopped() and (!coyote_timer.is_stopped() or is_on_floor()):
        velocity.y = JUMP_VELOCITY
        jump_buffer_timer.stop()
        coyote_timer.stop()
        coyote_time_activated = true


func handle_animation(direction: float) -> void:
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
