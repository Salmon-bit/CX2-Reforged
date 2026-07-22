extends Node2D

@export var object: PackedScene

func spawn():
	var spawnling = object.instantiate()
	spawnling.position.x = self.position.x
	spawnling.position.y = self.position.y
	
	return spawnling
