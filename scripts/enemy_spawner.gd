extends Node2D

@export var enemy: PackedScene
@export var parent: Node

func spawn():
	var spawnling = enemy.instantiate().duplicate()
	spawnling.position = position
	parent.add_child(spawnling)
	print("Spawned " + spawnling.name)
