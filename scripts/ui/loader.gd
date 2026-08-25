extends Control

@onready var progress_bar: ProgressBar = $MarginContainer/VBoxContainer/ProgressBar
@onready var label: Label = $MarginContainer/VBoxContainer/Label

var _target_path: String = ""
var _loading_started: bool = false

func _ready() -> void:
	_target_path = SceneLoader.get_target_scene_path()

	if _target_path == "":
		push_error("Loader: не указан путь к целевой сцене")
		return

	ResourceLoader.load_threaded_request(_target_path)
	_loading_started = true

func _process(_delta: float) -> void:
	if not _loading_started:
		return

	var progress: Array = []
	var status: int = ResourceLoader.load_threaded_get_status(_target_path, progress)

	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			var percent: float = progress[0] * 100.0
			progress_bar.value = percent
			label.text = "Загрузка... %d%%" % int(percent)

		ResourceLoader.THREAD_LOAD_LOADED:
			progress_bar.value = 100
			label.text = "Готово!"
			_loading_started = false
			var packed_scene: PackedScene = ResourceLoader.load_threaded_get(_target_path)
			call_deferred("_finish_loading", packed_scene)

		ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			label.text = "Ошибка загрузки!"
			push_error("Loader: не удалось загрузить сцену " + _target_path)
			_loading_started = false

func _finish_loading(packed_scene: PackedScene) -> void:
	get_tree().change_scene_to_packed(packed_scene)
