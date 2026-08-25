extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("go_back_to_level_select"):
		SceneLoader.goto_scene("res://scenes/ui/level_select.tscn")
	if Input.is_action_just_pressed("restart_room"):
		get_tree().reload_current_scene()
