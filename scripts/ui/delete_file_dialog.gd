extends Control

var counter = 0

func update_textures() -> void:
	if Autoload.data.lang == "ru":
		$HBoxContainer/MarginContainer2/DeleteFile.texture_normal = $Sprite1252.texture
		$HBoxContainer/MarginContainer2/DeleteFile.texture_pressed = $Sprite1253.texture
		$HBoxContainer/MarginContainer2/DeleteFile.texture_hover = $Sprite1253.texture
		
		$MarginContainer/Pashalka.texture = $Sprite1281.texture
	elif Autoload.data.lang == "en":
		$HBoxContainer/MarginContainer2/DeleteFile.texture_normal = $Sprite1250.texture
		$HBoxContainer/MarginContainer2/DeleteFile.texture_pressed = $Sprite1251.texture
		$HBoxContainer/MarginContainer2/DeleteFile.texture_hover = $Sprite1251.texture
		
		$MarginContainer/Pashalka.texture = $Sprite1280.texture

func _ready() -> void:
	update_textures()

func _on_yes_pressed() -> void:
	Autoload.clear_data()
	Autoload.click()
	get_tree().change_scene_to_file("res://scenes/ui/settings_scene.tscn")

func _on_no_pressed() -> void:
	Autoload.click()
	get_tree().change_scene_to_file("res://scenes/ui/settings_scene.tscn")

func _on_delete_file_pressed() -> void:
	$DeleteFile2.play()
	counter += 1
	if counter >= 10:
		$MarginContainer/Pashalka.show()
		counter = 0
