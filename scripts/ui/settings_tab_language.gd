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


func _on_de_pressed() -> void:
	Autoload.click()
	Autoload.data.lang = "de"
	Autoload.save_data()
	TranslationServer.set_locale("de")
	get_tree().current_scene.update_textures()


func _on_fr_pressed() -> void:
	Autoload.click()
	Autoload.data.lang = "fr"
	Autoload.save_data()
	TranslationServer.set_locale("fr")
	get_tree().current_scene.update_textures()
