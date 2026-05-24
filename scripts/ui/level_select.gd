extends Control

func get_level_num(node_name: String) -> String:
	# Вытаскивает все цифры из конца строки
	# "Level10" -> "10", "Btn3" -> "3"
	var result = ""
	for i in range(node_name.length() - 1, -1, -1):
		if node_name[i].is_valid_int():
			result = node_name[i] + result
		else:
			break
	return result

func go_to_level(btn: TextureButton) -> void:
	Autoload.click()
	var level_num = get_level_num(btn.name)
	get_tree().change_scene_to_file("res://scenes/levels/level_" + level_num + ".tscn")

func update_textures() -> void:
	var level_buttons = $MarginContainer/VBoxContainer.get_children()
	
	for lb: TextureButton in level_buttons:
		var level_num = get_level_num(lb.name)
		
		if int(level_num) - 1 > Autoload.data.level:
			lb.texture_normal = $Sprite210.texture
			lb.texture_hover = $Sprite210.texture
			lb.texture_pressed = $Sprite210.texture
			lb.disabled = true
		
		if not lb.disabled:
			lb.pressed.connect(Callable(self, "go_to_level").bind(lb))
	
	if Autoload.data.lang == "ru":
		$Sprite2D.texture = $Sprite951.texture

func _ready() -> void:
	update_textures()

func _on_back_btn_pressed() -> void:
	Autoload.click()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
