extends Node

var data = {
	"level": 0,
	"skin": 0,
	"ability": 0,
	"skins": [
		true,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false
	],
	"abilities": [
		true,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false
	],
	"money": 0,
	"difficulty": "easy",
	"lang": "en"
}

const null_data = {
	"level": 0,
	"skin": 0,
	"ability": 0,
	"skins": [
		true,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false
	],
	"abilities": [
		true,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false
	],
	"money": 0,
	"difficulty": "easy",
	"lang": "en"
}

const save_file = "user://save.json"
enum SPEEDS {STOPPED = 0, VERY_SLOW = 2500, SLOW = 5000, FAST = 10000, QUICK = 15000}

func save_data(dat = data):
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	file.store_string(JSON.stringify(dat, "  "))
	file.close()

func load_data():
	var file = FileAccess.open(save_file, FileAccess.READ)
	if file != null:
		var json_string = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var error = json.parse(json_string)
		if error == OK:
			data = json.data
	else:
		save_data(null_data)

func clear_data():
	save_data(null_data)
	load_data()

func click():
	$ClickSound.play()
	
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
