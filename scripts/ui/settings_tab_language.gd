extends TabBar


func _on_rus_pressed() -> void:
	Autoload.click()
	Autoload.data.lang = "ru"
	Autoload.save_data()
	get_tree().current_scene.update_textures()

func _on_eng_pressed() -> void:
	Autoload.click()
	Autoload.data.lang = "en"
	Autoload.save_data()
	get_tree().current_scene.update_textures()
