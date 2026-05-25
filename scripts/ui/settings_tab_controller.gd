extends TabBar

func _ready() -> void:
	$MarginContainer/VBoxContainer/Hints.button_pressed = Autoload.data.show_controller_hints
	var selected = 0
	match Autoload.data.controller_type:
		"XBox":
			selected = 0
		"PS":
			selected = 1
		"Nin":
			selected = 2
	$MarginContainer/VBoxContainer/OptionButton.selected = selected

func _on_option_button_item_selected(index: int) -> void:
	Autoload.click()
	match index:
		0:
			Autoload.data.controller_type = "XBox"
		1:
			Autoload.data.controller_type = "PS"
		2:
			Autoload.data.controller_type = "Nin"
	
	Autoload.save_data()


func _on_hints_toggled(toggled_on: bool) -> void:
	Autoload.click()
	Autoload.data.show_controller_hints = toggled_on
	Autoload.save_data()
