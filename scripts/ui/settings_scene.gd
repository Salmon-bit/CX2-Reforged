extends Control

var wait_btn = false
var idx = -1

func update_textures() -> void:
	if Autoload.data.lang == "ru":
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Easy.texture_normal = $Sprites/Sprite1452.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Easy.texture_pressed = $Sprites/Sprite923.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Easy.texture_hover = $Sprites/Sprite923.texture
		
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Normal.texture_normal = $Sprites/Sprite1292.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Normal.texture_hover = $Sprites/Sprite1293.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Normal.texture_pressed = $Sprites/Sprite1293.texture
		
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Hard.texture_normal = $Sprites/Sprite932.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Hard.texture_hover = $Sprites/Sprite933.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Hard.texture_pressed = $Sprites/Sprite933.texture
		
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/TextureRect.texture = $Sprites/Sprite711.texture
		
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/MarginContainer2/DeleteFile.texture_normal = $Sprites/Sprite1222.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/MarginContainer2/DeleteFile.texture_hover = $Sprites/Sprite1223.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/MarginContainer2/DeleteFile.texture_pressed = $Sprites/Sprite1223.texture

	elif Autoload.data.lang == "en":
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Easy.texture_normal = $Sprites/Sprite920.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Easy.texture_pressed = $Sprites/Sprite921.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Easy.texture_hover = $Sprites/Sprite921.texture
		
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Normal.texture_normal = $Sprites/Sprite1290.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Normal.texture_hover = $Sprites/Sprite1291.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Normal.texture_pressed = $Sprites/Sprite1291.texture
		
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Hard.texture_normal = $Sprites/Sprite930.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Hard.texture_hover = $Sprites/Sprite931.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/HBoxContainer/Hard.texture_pressed = $Sprites/Sprite931.texture
		
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/TextureRect.texture = $Sprites/Sprite710.texture
		
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/MarginContainer2/DeleteFile.texture_normal = $Sprites/Sprite1220.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/MarginContainer2/DeleteFile.texture_hover = $Sprites/Sprite1221.texture
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/MarginContainer2/DeleteFile.texture_pressed = $Sprites/Sprite1221.texture

	if Autoload.data.difficulty == "easy":
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/SelectedDifficulty.texture = $Sprites/Sprite1450.texture
	elif Autoload.data.difficulty == "normal":
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/SelectedDifficulty.texture = $Sprites/Sprite1451.texture
	elif Autoload.data.difficulty == "hard":
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/SelectedDifficulty.texture = $Sprites/Sprite1454.texture
	elif Autoload.data.difficulty == "easyyy":
		$MarginContainer/TabContainer/Main/MarginContainer/VBoxContainer/SelectedDifficulty.texture = $Sprites/Sprite1453.texture
		Autoload.add_trophey(3)

func _ready() -> void:
	update_textures()

func _on_back_pressed() -> void:
	Autoload.click()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("next_tab"):
		if $MarginContainer/TabContainer.current_tab + 1 > len($MarginContainer/TabContainer.get_children()) - 1:
			$MarginContainer/TabContainer.current_tab = 0
		else:
			$MarginContainer/TabContainer.current_tab += 1
	if Input.is_action_just_pressed("prev_tab"):
		if $MarginContainer/TabContainer.current_tab - 1 < 0:
			$MarginContainer/TabContainer.current_tab = len($MarginContainer/TabContainer.get_children()) - 1
		else:
			$MarginContainer/TabContainer.current_tab -= 1

func _on_tab_container_tab_changed(tab: int) -> void:
	Autoload.click()
	if tab == 1:
		$Back.hide()
	else:
		$Back.show()

func _physics_process(_delta: float) -> void:
	if wait_btn and Input.is_action_just_pressed("select"):
		$MarginContainer/TabContainer/Controller/MarginContainer/VBoxContainer/OptionButton.select(idx)
		$MarginContainer/TabContainer/Controller/MarginContainer/VBoxContainer/OptionButton.get_popup().hide()


func _on_option_button_item_focused(index: int) -> void:
	Autoload.click()
	wait_btn = true
	idx = index
