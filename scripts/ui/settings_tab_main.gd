extends TabBar


func _on_easy_pressed() -> void:
	Autoload.click()
	Autoload.data.difficulty = "easy"
	Autoload.save_data()
	get_tree().current_scene.update_textures()

func _on_normal_pressed() -> void:
	Autoload.click()
	Autoload.data.difficulty = "normal"
	Autoload.save_data()
	get_tree().current_scene.update_textures()

func _on_hard_pressed() -> void:
	Autoload.click()
	Autoload.data.difficulty = "hard"
	Autoload.save_data()
	get_tree().current_scene.update_textures()

func _on_delete_file_pressed() -> void:
	Autoload.click()
	get_tree().change_scene_to_file("res://scenes/ui/delete_file_dialog.tscn")
