extends Control

func update_textures():
	if Autoload.data.lang == "ru":
		$Info.texture = $RU_SPRITES/Sprite981.texture
	
	var c = $MarginContainer/VBoxContainer
	var children = c.get_children()
	
	for i in range(len(children) - 1):
		var btn: TextureButton = c.get_node("HBoxContainer" + str(i + 1)).get_node("Btn" + str(i))
		if Autoload.data.level < int(c.get_node("HBoxContainer" + str(i + 1)).get_children()[0].name):
			btn.texture_normal = $Sprite210.texture
			btn.texture_pressed = $Sprite210.texture
			btn.texture_hover = $Sprite210.texture
			btn.disabled = true
		else:
			if Autoload.data.lang == "ru":
				btn.texture_normal = $RU_SPRITES.get_node(str(c.get_node("HBoxContainer" + str(i + 1)).get_children()[0].name)).texture
				btn.texture_pressed = $RU_SPRITES.get_node(str(c.get_node("HBoxContainer" + str(i + 1)).get_children()[0].name + "_1")).texture
				btn.texture_hover = $RU_SPRITES.get_node(str(c.get_node("HBoxContainer" + str(i + 1)).get_children()[0].name + "_1")).texture
			btn.pressed.connect(Callable(self, "on_btn_pressed").bind(btn))
	
	if Autoload.data.lang == "ru":
		$MarginContainer2/VBoxContainer/Selected.texture = $RU_SPRITES/Sprite711.texture
	
	$MarginContainer2/VBoxContainer/Icon.texture = $AbilityIcons.get_node(str(int(Autoload.data.ability))).texture

func _ready():
	update_textures()

func _on_texture_button_pressed() -> void:
	Autoload.click()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func on_btn_pressed(btn: TextureButton):
	Autoload.click()
	Autoload.data.ability = int(Autoload.get_level_num(btn.name))
	Autoload.save_data()
	update_textures()
