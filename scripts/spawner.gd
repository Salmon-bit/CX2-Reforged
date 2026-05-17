extends Node2D

@export var object: PackedScene

func spawn():
	var spawnling = object.instantiate()
	spawnling.position.x = position.x
	spawnling.position.y = position.y
	
	return spawnling
