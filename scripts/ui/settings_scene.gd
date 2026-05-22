extends Control

func update_textures() -> void:
	if Autoload.data.lang == "ru":
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Easy.texture_normal = $Sprite1452.texture
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Easy.texture_pressed = $Sprite923.texture
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Easy.texture_hover = $Sprite923.texture

		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Normal.texture_normal = $Sprite1292.texture
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Normal.texture_hover = $Sprite1293.texture
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Normal.texture_pressed = $Sprite1293.texture

		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Hard.texture_normal = $Sprite932.texture
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Hard.texture_hover = $Sprite933.texture
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Hard.texture_pressed = $Sprite933.texture

		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/TextureRect.texture = $Sprite711.texture

		$MarginContainer/HBoxContainer/MarginContainer3/VBoxContainer/DeleteFile.texture_normal = $Sprite1222.texture
		$MarginContainer/HBoxContainer/MarginContainer3/VBoxContainer/DeleteFile.texture_hover = $Sprite1223.texture
		$MarginContainer/HBoxContainer/MarginContainer3/VBoxContainer/DeleteFile.texture_pressed = $Sprite1223.texture
	elif Autoload.data.lang == "en":
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Easy.texture_normal = $Sprite920.texture
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Easy.texture_pressed = $Sprite921.texture
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Easy.texture_hover = $Sprite921.texture

		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Normal.texture_normal = $Sprite1290.texture
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Normal.texture_hover = $Sprite1291.texture
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Normal.texture_pressed = $Sprite1291.texture

		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Hard.texture_normal = $Sprite930.texture
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Hard.texture_hover = $Sprite931.texture
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Hard.texture_pressed = $Sprite931.texture

		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/TextureRect.texture = $Sprite710.texture
		
		$MarginContainer/HBoxContainer/MarginContainer3/VBoxContainer/DeleteFile.texture_normal = $Sprite1220.texture
		$MarginContainer/HBoxContainer/MarginContainer3/VBoxContainer/DeleteFile.texture_hover = $Sprite1221.texture
		$MarginContainer/HBoxContainer/MarginContainer3/VBoxContainer/DeleteFile.texture_pressed = $Sprite1221.texture

	if Autoload.data.difficulty == "easy":
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/SelectedDifficulty.texture = $Sprite1450.texture
	elif Autoload.data.difficulty == "normal":
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/SelectedDifficulty.texture = $Sprite1451.texture
	elif Autoload.data.difficulty == "hard":
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/SelectedDifficulty.texture = $Sprite1454.texture
	elif Autoload.data.difficulty == "easyyy":
		$MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/SelectedDifficulty.texture = $Sprite1453.texture
		Autoload.add_trophey(3)

func _ready() -> void:
	update_textures()

func _on_back_pressed() -> void:
	Autoload.click()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func _on_delete_file_pressed() -> void:
	Autoload.click()
	get_tree().change_scene_to_file("res://scenes/ui/delete_file_dialog.tscn")

func _on_easy_pressed() -> void:
	Autoload.click()
	Autoload.data.difficulty = "easy"
	Autoload.save_data()
	update_textures()

func _on_normal_pressed() -> void:
	Autoload.click()
	Autoload.data.difficulty = "normal"
	Autoload.save_data()
	update_textures()

func _on_hard_pressed() -> void:
	Autoload.click()
	Autoload.data.difficulty = "hard"
	Autoload.save_data()
	update_textures()

func _on_rus_pressed() -> void:
	Autoload.click()
	Autoload.data.lang = "ru"
	Autoload.save_data()
	update_textures()

func _on_eng_pressed() -> void:
	Autoload.click()
	Autoload.data.lang = "en"
	Autoload.save_data()
	update_textures()

func _on_auto_auth_toggled(toggled_on: bool) -> void:
	Autoload.click()
	Autoload.data.auto_auth = toggled_on
	Autoload.save_data()
	update_textures()


func _on_web_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/game_jolt_settings.tscn")
