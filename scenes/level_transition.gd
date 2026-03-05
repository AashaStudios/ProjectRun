extends Area2D


func _on_body_entered(_body: Node2D) -> void:
    SceneTransition.change_scene_to("res://scenes/main_menu.tscn")
