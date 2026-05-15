extends Node

var win = false
var mp = 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if len(get_children()) == 0 and not win:
		win = true
		$"../WinScreen".position = $"../CharacterBody2D".position
		$"../WinScreen".show()
	
	$"../WinScreen".rotation += mp * delta
	
	if $"../WinScreen".rotation > 0.2 or $"../WinScreen".rotation < -0.2:
		mp *= -1
