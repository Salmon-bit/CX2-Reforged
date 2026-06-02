extends Sprite2D


func _ready() -> void:
	position.y = 101 + 69 * (Autoload.pointer_level - 1)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pointer_up"):
		if position.y > 101:
			position.y -= 69
			Autoload.pointer_level -= 1
	if Input.is_action_just_pressed("pointer_down"):
		if position.y < 377:
			position.y += 69
			Autoload.pointer_level += 1
	if Input.is_action_just_pressed("select"):
		if Autoload.pointer_level - 1 <= Autoload.data.level:
			get_tree().change_scene_to_file("res://scenes/levels/level_" + str(Autoload.pointer_level) + ".tscn")
		else:
			print("[POINTER]: You shall not pass!")
