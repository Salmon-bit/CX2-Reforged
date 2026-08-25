extends Node2D

@onready var AnS = $AnimatedSprite2D
@onready var l = $Label

func _ready() -> void:
	AnS.play()

func _process(_delta: float) -> void:
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	SceneLoader.goto_scene("res://scenes/levels/level_1.tscn")

func _on_button_pressed() -> void:
	SceneLoader.goto_scene("res://scenes/levels/level_1.tscn")

func _on_animated_sprite_2d_frame_changed() -> void:
	l.text = "CUTSCENE_1_FRAME_" + str(AnS.frame)
