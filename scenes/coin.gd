extends Area2D


@onready var game_manager: Node = %GameManager


func _on_body_entered(_body: Node2D) -> void:
    game_manager.coins += 1
    print("Coins: " + str(game_manager.coins))
    queue_free()
