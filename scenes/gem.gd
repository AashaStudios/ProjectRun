extends Area2D


func _ready() -> void:
    var tween := create_tween()
    tween.set_loops()
    tween.tween_property($"Sprite2D", "position", Vector2(0, -4), 0.75).set_trans(Tween.TRANS_CUBIC)
    tween.tween_property($"Sprite2D", "position", Vector2(0, 0), 0.75).set_trans(Tween.TRANS_CUBIC)


func _on_body_entered(_body: Node2D) -> void:
    print("+1 Gem")
    queue_free()
