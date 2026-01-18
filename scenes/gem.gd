extends Area2D


@onready var game_manager: Node = %GameManager


func _ready() -> void:
    var tween := create_tween()
    tween.set_loops()
    tween.tween_property($"Sprite2D", "position", Vector2(0, -4), 0.75).set_trans(Tween.TRANS_CUBIC)
    tween.tween_property($"Sprite2D", "position", Vector2(0, 0), 0.75).set_trans(Tween.TRANS_CUBIC)


func _on_body_entered(_body: Node2D) -> void:
    game_manager.gems += 1
    print("Gems: " + str(game_manager.gems))
    queue_free()
