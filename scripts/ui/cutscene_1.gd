extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.play()

func _process(_delta: float) -> void:
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
