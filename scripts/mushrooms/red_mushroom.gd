extends RigidBody2D

var can_melle_attack = true
var can_ranged_attack = false
var hp = 100


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.name)
	print(hp)
	if "arrow" in area.get_parent().name.to_lower():
		hp -= 15


func _process(_delta: float) -> void:
	if hp <= 0:
		queue_free()
