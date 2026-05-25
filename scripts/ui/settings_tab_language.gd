extends TabBar


func _on_rus_pressed() -> void:
	Autoload.click()
	Autoload.data.lang = "ru"
	Autoload.save_data()
	TranslationServer.set_locale("ru")
	get_tree().current_scene.update_textures()

func _on_eng_pressed() -> void:
	Autoload.click()
	Autoload.data.lang = "en"
	Autoload.save_data()
	TranslationServer.set_locale("en")
	get_tree().current_scene.update_textures()
