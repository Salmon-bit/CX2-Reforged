extends Node2D

var showing_trophey = false
var speed = 80
var go_back = false
var max_height = 550
var min_height = 700

func show_trophey(trophey: Array):
	showing_trophey = true
	$Text.text = trophey[0]
	$Description.text = trophey[1]
	if $Icons.get_node(str(trophey[4])) == null:
		$Icon.texture = null
	else:
		$Icon.texture = $Icons.get_node(str(trophey[4])).texture

func _ready() -> void:
	show()
	position = Vector2(130, 648)

func _process(delta: float) -> void:
	if showing_trophey and position.y >= max_height and not go_back:
		position.y -= speed * delta
	elif showing_trophey and position.y <= max_height and not go_back:
		go_back = true
		$Timer.start()
	if showing_trophey and go_back and $Timer.time_left == 0.0:
		position.y += speed * delta
	if showing_trophey and go_back and position.y >= min_height:
		showing_trophey = false
		go_back = false
		position = Vector2(130, 648)
