extends Control

func _ready() -> void:
	$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/Username.text = GameJolt.get_user_name()
	$MarginContainer/VBoxContainer/HBoxContainer2/MarginContainer/GameToken.text = GameJolt.get_user_token()
	$MarginContainer/VBoxContainer/HBoxContainer3/Button.button_pressed = Autoload.data.auto_auth
	GameJolt.users_auth_completed.connect(check_auth)

func _on_back_pressed() -> void:
	GameJolt.set_user_name($MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/Username.text)
	GameJolt.set_user_token($MarginContainer/VBoxContainer/HBoxContainer2/MarginContainer/GameToken.text)
	Autoload.data.auto_auth = $MarginContainer/VBoxContainer/HBoxContainer3/Button.button_pressed
	if Autoload.data.auto_auth:
		Autoload.data.username = GameJolt.get_user_name()
		Autoload.data.usertoken = GameJolt.get_user_token()
	Autoload.save_data()
	get_tree().change_scene_to_file("res://scenes/ui/settings_scene.tscn")


func _on_button_toggled(toggled_on: bool) -> void:
	Autoload.data.auto_auth = toggled_on

func _on_login_pressed() -> void:
	GameJolt.users_auth()

func check_auth(response) -> void:
	if response.success:
		$MarginContainer/VBoxContainer/Status.text = "Login status: Logged In"
	else:
		$MarginContainer/VBoxContainer/Status.text = "Login status: Error"
