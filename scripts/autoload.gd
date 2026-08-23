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
		false,
		false
	],
	"money": 0,
	"difficulty": "normal",
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
		false,
		false
	],
	"show_controller_hints": false,
	"controller_type": "PS"
}

# Name, Description, GameJolt ID, is secret?, id
const tropheys = [
	["The begining of the begining", "Kill first mushroom", "300171", false, 0], # Drawn
	["Starting killer", "Kill 15 mushrooms", "300174", false, 1], # Drawn
	["Friend!?", "Kill first boss", "300172", false, 2],
	["BaBy", "Discover new difficulty", "0", true, 3], # Drawn
	["Defeat", "Die", "300207", false, 4], # Drawn
	["Baby Xlebushek", "Complete game on easy difficulty", "300186", false, 5],
	["Rain & Thunder", "Kill second boss", "300173", false, 6], # Drawn
	["Advanced killer", "Kill 100 mushrooms", "300176", false, 7], # Drawn
	["Xlebushek", "Complete game on easy difficulty", "300183", false, 8],
	["Real Xlebushek", "Complete game on hard difficulty", "300185", false, 9],
	["And what now?", "Get all tropheys", "300180", false, 10], # Drawn
	["Ultimate Killer", "Kill 1000 mushrooms", "300895", false, 11]
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
		false,
		false
	],
	"show_controller_hints": false,
	"controller_type": "PS"
}

const save_file = "user://save.json"
# Скрытый файл со статистикой/секретными данными - хранится в бинарном
# формате Godot (store_var), а не в читаемом JSON, специально для того,
# чтобы его нельзя было легко открыть и отредактировать в текстовом
# редакторе (используется для пасхалок).
const save_stats = "user://stats.save"

enum SPEEDS {STOPPED = 0, VERY_SLOW = 2500, SLOW = 5000, FAST = 10000, QUICK = 15000}

var pointer_level = 1

func fetched_scores(response):
	if response.success == "true":
		if float(response.scores[0].score) < data.kills:
			print("[SCORES FETCHER]: Updating GameJolt scores...")
			GameJolt.scores_add(str(int(data.kills)), str(int(data.kills)), "1084203")
			print("[SCORES FETCHER]: GameJolt scores Updated!")
		elif float(response.scores[0].score) > data.kills:
			print("[SCORES FETCHER]: Updating local scores...")
			data.kills = float(response.scores[0].score)
			print("[SCORES FETCHER]: Local scores updated!")
	else:
		print("[SCORES FETCHER]: Error getting GameJolt scores, info: " + response.message)

func scene_changed():
	print("[INFO]: Scene Changed")
	GameJolt.scores_fetch(null, "1084203", "", null, null, true)

func add_trophey(id: int):
	if not data.tropheys[id]:
		GameJolt.trophies_add_achieved(tropheys[id][2])
		get_tree().current_scene.get_node("CanvasLayer").get_node("TropheyManager").show_trophey(tropheys[id])
		data.tropheys[id] = true
	
	var broken = false
	for i in range(len(data.tropheys)):
		if not data.tropheys[i] and i != 10:
			broken = true
			break
	if not broken:
		GameJolt.trophies_add_achieved(tropheys[id][10])
		get_tree().current_scene.get_node("CanvasLayer").get_node("TropheyManager").show_trophey(tropheys[id])
		data.tropheys[id] = true

func _ready() -> void:
	GameJolt.set_game_id(GameId.game_id)
	GameJolt.set_private_key(GameId.secret_key)
	
	var main_exists = FileAccess.file_exists(save_file)
	var stats_exists = FileAccess.file_exists(save_stats)
	
	if not main_exists and not stats_exists:
		# Совсем свежая установка - создаём оба файла с дефолтными данными
		data = null_data.duplicate(true)
		save_data(data)
	else:
		load_data()
		# Если один из двух файлов отсутствовал или был повреждён - тут же
		# пересоздаём его из уже загруженных/дефолтных значений. Второй файл
		# при этом не трогаем, поэтому его данные не теряются.
		save_data(data)
	
	if data.auto_auth:
		GameJolt.set_user_name(data.username)
		GameJolt.set_user_token(data.usertoken)
	
	get_tree().scene_changed.connect(scene_changed)
	GameJolt.scores_fetch_completed.connect(fetched_scores)
	
	TranslationServer.set_locale(data.lang)


func save_data(dat = data) -> void:
	print("[SAVE]: Started saving data...")
	
	# Открытая часть - её безопасно редактировать руками, ни на что критичное
	# в прохождении не влияет.
	var other_data = {
			"skin": dat.skin,
			"ability": dat.ability,
			"auto_auth": dat.auto_auth,
			"cloud_save": dat.cloud_save,
			"controller_type": dat.controller_type,
			"difficulty": dat.difficulty,
			"have_auth": dat.have_auth,
			"lang": dat.lang,
			"show_controller_hints": dat.show_controller_hints,
		}
	# Закрытая часть - напрямую влияет на прогресс/статистику, хранится в
	# бинарном виде (не читается и не правится текстовым редактором).
	var stats = {
			"kills": dat.kills,
			"deaths": dat.deaths,
			"level": dat.level,
			"money": dat.money,
			"skins": dat.skins,
			"username": dat.username,
			"usertoken": dat.usertoken,
			"tropheys": dat.tropheys,
		}
	
	var save = FileAccess.open(save_file, FileAccess.WRITE)
	if save != null:
		save.store_string(JSON.stringify(other_data, "  "))
		save.close()
	else:
		push_error("[SAVE]: Could not open save.json for writing!")
	
	var file_stats = FileAccess.open(save_stats, FileAccess.WRITE)
	if file_stats != null:
		file_stats.store_var(stats)
		file_stats.close()
	else:
		push_error("[SAVE]: Could not open stats.save for writing!")
	
	print("[SAVE]: Data saved!")


func load_data() -> void:
	print("[LOAD]: Started loading data...")
	# Начинаем с дефолтов, чтобы если один из файлов отсутствует/битый -
	# в этой части просто останутся дефолтные значения, а не пропадут
	# ключи целиком и не обнулится то, что успешно загрузилось из второго файла.
	var merged: Dictionary = null_data.duplicate(true)
	
	var file_main = FileAccess.open(save_file, FileAccess.READ)
	if file_main != null:
		var json_string = file_main.get_as_text()
		file_main.close()
		var json = JSON.new()
		var error = json.parse(json_string)
		if error == OK and typeof(json.data) == TYPE_DICTIONARY:
			merged.merge(json.data, true)
		else:
			push_warning("[LOAD]: save.json is corrupted, using defaults for that part.")
	else:
		print("[LOAD]: No save.json - using defaults for that part.")
	
	var file_stats = FileAccess.open(save_stats, FileAccess.READ)
	if file_stats != null:
		var stats_data = file_stats.get_var()
		file_stats.close()
		if typeof(stats_data) == TYPE_DICTIONARY:
			merged.merge(stats_data, true)
		else:
			push_warning("[LOAD]: stats.save is corrupted, using defaults for that part.")
	else:
		print("[LOAD]: No stats.save - using defaults for that part.")
	
	data = merged
	print("[LOAD]: Data loaded!")

func clear_data() -> void:
	data = null_data.duplicate(true)
	save_data(data)

func click():
	$ClickSound.play()

func get_level_num(node_name: String) -> String:
	var result = ""
	for i in range(node_name.length() - 1, -1, -1):
		if node_name[i].is_valid_int():
			result = node_name[i] + result
		else:
			break
	return result
