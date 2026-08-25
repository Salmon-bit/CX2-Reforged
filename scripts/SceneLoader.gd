extends Node

var _target_scene_path: String = ""
var _loader_scene_path: String = "res://scenes/ui/loader.tscn" # путь к твоей сцене загрузки

func goto_scene(path: String) -> void:
	_target_scene_path = path
	get_tree().change_scene_to_file(_loader_scene_path)

func get_target_scene_path() -> String:
	return _target_scene_path
