extends StaticBody2D

var hp = 50
var i_am_box = true

func _process(_delta):
	if hp <= 0:
		queue_free()

func attack(damage_points):
	hp -= damage_points
