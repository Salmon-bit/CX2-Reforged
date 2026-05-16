extends StaticBody2D

var hp = 50
var is_attacking = false
var is_mushroom = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	var object = area.get_parent()
	print("[BOX] Entered object " + object.name)
	
	if "mushroom" in object.name.to_lower():
		is_mushroom = true
	else:
		is_mushroom = false
	
	if "arrow" in object.name.to_lower() or is_mushroom:
		is_attacking = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	var object = area.get_parent()
	print("[BOX] Exited object " + object.name)
	
	if "mushroom" in object.name.to_lower():
		is_mushroom = true
	else:
		is_mushroom = false
	
	if "arrow" in object.name.to_lower() or is_mushroom:
		is_attacking = false
	
	timer = 0

var timer = 0.5

func _process(delta: float) -> void:
	if is_attacking:
		timer -= delta
		if timer <= 0:
			if is_mushroom:
				hp -= 7
			else:
				hp -= 10
			timer = 0.5
	
	if hp <= 0:
		queue_free()
