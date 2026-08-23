extends Node2D

@export var objects: Array[PackedScene]

func spawn() -> void:
	var i = randi_range(0, len(objects) - 1)
	var spawnling = objects[i].instantiate()
	
	spawnling.position.x = self.position.x
	spawnling.position.y = self.position.y
	
	get_parent().add_child(spawnling)
