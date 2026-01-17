extends CharacterBody2D


const SPEED = 150
const JUMP_VELOCITY = -250

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity += get_gravity() * delta

    if Input.is_action_pressed("jump") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    var direction := Input.get_axis("left", "right")
    
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
    
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
