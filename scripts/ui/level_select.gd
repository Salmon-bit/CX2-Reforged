extends Control


func _ready() -> void:
	update_textures()
	for t in $MarginContainer2/VBoxContainer.get_children():
		t.text ="– " + TranslationServer.translate(t.text)

func go_to_level(btn: TextureButton) -> void:
	Autoload.click()
	var level_num = Autoload.get_level_num(btn.name)
	SceneLoader.goto_scene("res://scenes/levels/level_" + level_num + ".tscn")

func update_textures() -> void:
	var level_buttons = $MarginContainer/VBoxContainer.get_children()
	
	for lb: TextureButton in level_buttons:
		var level_num = Autoload.get_level_num(lb.name)
		
		if int(level_num) - 1 > Autoload.data.level:
			lb.texture_normal = $Sprite210.texture
			lb.texture_hover = $Sprite210.texture
			lb.texture_pressed = $Sprite210.texture
			lb.disabled = true
		
		if not lb.disabled and lb.name not in ["Level1", "Level5"]:
			lb.pressed.connect(Callable(self, "go_to_level").bind(lb))
	

func _on_back_btn_pressed() -> void:
	Autoload.click()
	SceneLoader.goto_scene("res://scenes/ui/main_menu.tscn")

func _on_level_1_pressed() -> void:
	Autoload.click()
	SceneLoader.goto_scene("res://scenes/ui/cutscene_1.tscn")
