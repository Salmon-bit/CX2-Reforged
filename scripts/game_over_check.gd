extends Node

var win = false
var mp = 0.5
var counter = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	counter = 0
	for e in get_children():
		if e.get_node("Sprite").animation == "dead":
			counter += 1
	
	if counter == len(get_children()):
		win = true
	
	if win:
		$"../WinScreen".position = get_parent().get_node("Player").position
		$"../WinScreen".show()
		Autoload.data.level = int(Autoload.get_level_num(get_parent().name))
		Autoload.save_data()
	
	$"../WinScreen".rotation += mp * delta
	
	if $"../WinScreen".rotation > 0.2 or $"../WinScreen".rotation < -0.2:
		mp *= -1
