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
	"money": 0,
	"difficulty": "easy",
	"lang": "en",
	"username": "",
	"usertoken": "",
	"have_auth": false,
	"auto_auth": false,
	"cloud_save": false,
	"kills": 0,
	"deaths": 0,
	"tropheys": [
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
	]
}

# Name, Description, GameJolt ID, is secret?, id
const tropheys = [
	["The begining of the begining", "Kill first mushroom", "300171", false, 0],
	["Starting killer", "Kill 15 mushrooms", "300174", false, 1],
	["Friend!?", "Kill first boss", "300172", false, 2],
	["BaBy", "Discover new difficulty", true, 3],
	["Defeat", "Die", "300207", false, 4],
	["Baby Xlebushek", "Complete game on easy difficulty", "300186", false, 5],
	["Rain & Thunder", "Defeat second boss", "300173", false, 6],
	["Advanced killer", "Kill 100 mushrooms", "300176", false, 7],
	["Xlebushek", "Complete game on easy difficulty", "300183", false, 8],
	["Real Xlebushek", "Complete game on hard difficulty", "300185", false, 9],
	["And what now?", "Get all tropheys", "300180", false, 10]
]

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
	"money": 0,
	"difficulty": "easy",
	"lang": "en",
	"username": "",
	"usertoken": "",
	"have_auth": false,
	"auto_auth": false,
	"cloud_save": false,
	"kills": 0,
	"deaths": 0,
	"tropheys": [
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
	]
}

const save_file = "user://save.json"
enum SPEEDS {STOPPED = 0, VERY_SLOW = 2500, SLOW = 5000, FAST = 10000, QUICK = 15000}

func add_trophey(id: int):
	if not data.tropheys[id]:
		GameJolt.trophies_add_achieved(tropheys[id][2])
		get_tree().current_scene.get_node("CanvasLayer").get_node("TropheyManager").show_trophey(tropheys[id])
		data.tropheys[id] = true

func _ready() -> void:
	GameJolt.set_game_id(GameId.game_id)
	GameJolt.set_private_key(GameId.secret_key)
	load_data()
	
	if data.auto_auth:
		GameJolt.set_user_name(data.username)
		GameJolt.set_user_token(data.usertoken)

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
