extends Control

func _ready() -> void:
	$MarginContainer/VBoxContainer/HBoxContainer/Username.text = GameJolt.get_user_name()
	$MarginContainer/VBoxContainer/HBoxContainer2/GameToken.text = GameJolt.get_user_token()
	$MarginContainer/VBoxContainer/HBoxContainer3/CheckButton.button_pressed = Autoload.data.auto_auth
	GameJolt.users_auth_completed.connect(check_auth)
	GameJolt.users_auth()

func _on_back_pressed() -> void:
	Autoload.click()
	GameJolt.set_user_name($MarginContainer/VBoxContainer/HBoxContainer/Username.text)
	GameJolt.set_user_token($MarginContainer/VBoxContainer/HBoxContainer2/GameToken.text)
	Autoload.data.auto_auth = $MarginContainer/VBoxContainer/HBoxContainer3/CheckButton.button_pressed
	if Autoload.data.auto_auth:
		Autoload.data.username = GameJolt.get_user_name()
		Autoload.data.usertoken = GameJolt.get_user_token()
	Autoload.save_data()
	get_tree().change_scene_to_file("res://scenes/ui/settings_scene.tscn")
	
func _on_login_pressed() -> void:
	Autoload.click()
	GameJolt.set_user_name($MarginContainer/VBoxContainer/HBoxContainer/Username.text)
	GameJolt.set_user_token($MarginContainer/VBoxContainer/HBoxContainer2/GameToken.text)
	GameJolt.users_auth()

func check_auth(response) -> void:
	print("[AUTH RESPONSE]: " + str(response))
	if response.success == "true":
		$MarginContainer/VBoxContainer/Status.text = "Login status: Logged In\n"
	else:
		$MarginContainer/VBoxContainer/Status.text = "Login status: Error\n" + response.message

func _on_check_button_pressed() -> void:
	Autoload.click()
