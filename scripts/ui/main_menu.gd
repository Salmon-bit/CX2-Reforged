extends Control

# Variables
var timer = 2
var particle: CPUParticles2D = null
var logo: Sprite2D = null
var mp = 1
var rotate_deg = 0.5

func _ready() -> void:
	particle = $CPUParticles2D
	particle.emitting = true
	logo = $Logo
	logo.rotation = 0.01

	Autoload.load_data()
	GameJolt.set_game_id(GameId.game_id)
	GameJolt.set_private_key(GameId.secret_key)
	update_textures()
	GameJolt.sessions_open()

func update_textures():
	if Autoload.data.lang == "ru":
		$Version.texture = $Sprite1061.texture
		$MarginContainer/VBoxContainer/MarginContainer/PlayButton.texture_normal = $Sprite122.texture
		$MarginContainer/VBoxContainer/MarginContainer/PlayButton.texture_hover = $Sprite123.texture
		$MarginContainer/VBoxContainer/MarginContainer/PlayButton.texture_pressed = $Sprite123.texture
		$MarginContainer/VBoxContainer/MarginContainer3/AbilitiesButton.texture_normal = $Sprite362.texture
		$MarginContainer/VBoxContainer/MarginContainer3/AbilitiesButton.texture_hover = $Sprite363.texture
		$MarginContainer/VBoxContainer/MarginContainer3/AbilitiesButton.texture_pressed = $Sprite363.texture
		$MarginContainer/VBoxContainer/MarginContainer4/ChallengesButton.texture_normal = $Sprite892.texture
		$MarginContainer/VBoxContainer/MarginContainer4/ChallengesButton.texture_hover = $Sprite893.texture
		$MarginContainer/VBoxContainer/MarginContainer4/ChallengesButton.texture_pressed = $Sprite893.texture
		$MarginContainer/VBoxContainer/MarginContainer5/SettingsButton.texture_normal = $Sprite882.texture
		$MarginContainer/VBoxContainer/MarginContainer5/SettingsButton.texture_hover = $Sprite883.texture
		$MarginContainer/VBoxContainer/MarginContainer5/SettingsButton.texture_pressed = $Sprite883.texture
		$MarginContainer/VBoxContainer/MarginContainer6/SkinsButton.texture_normal = $Sprite2222.texture
		$MarginContainer/VBoxContainer/MarginContainer6/SkinsButton.texture_hover = $Sprite2223.texture
		$MarginContainer/VBoxContainer/MarginContainer6/SkinsButton.texture_pressed = $Sprite2223.texture
		$MarginContainer/VBoxContainer/MarginContainer2/ExitButton.texture_normal = $Sprite152.texture
		$MarginContainer/VBoxContainer/MarginContainer2/ExitButton.texture_hover = $Sprite153.texture
		$MarginContainer/VBoxContainer/MarginContainer2/ExitButton.texture_pressed = $Sprite153.texture

func _process(delta: float) -> void:
	# Emit random sprites
	timer -= delta
	if timer <= 0:
		timer = 1.5
		var sprites = $Sprites.get_children()
		var new_texture = sprites[randi_range(0, len(sprites) - 1)].texture
		particle.texture = new_texture
		particle.emitting = true
	
	# Rotate Logo
	logo.rotation += rotate_deg * delta
	if logo.rotation >= 0.3 or logo.rotation <= -0.3:
		rotate_deg *= -1

# Buttons Callback
func _on_exit_button_pressed() -> void:
	GameJolt.sessions_close()
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	Autoload.click()
	get_tree().change_scene_to_file("res://scenes/ui/settings_scene.tscn")

func _on_play_button_pressed() -> void:
	Autoload.click()
	get_tree().change_scene_to_file("res://scenes/ui/level_select.tscn")

func _on_abilities_button_pressed() -> void:
	Autoload.click()
	get_tree().change_scene_to_file("res://scenes/ui/abilities.tscn")
