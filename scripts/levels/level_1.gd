extends Node2D

var spawner: Node2D
var enemies: Node

func _ready() -> void:
	enemies = $Enemies
	#spawner = $Spawners/EnemySpawner
	#enemies.add_child(spawner.spawn())
