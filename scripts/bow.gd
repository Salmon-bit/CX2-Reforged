extends Node2D


func _process(delta: float) -> void:
	self.rotation += get_angle_to(get_global_mouse_position())
