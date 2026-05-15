extends Node2D

var spawner: Node2D

func _ready() -> void:
	spawner = $EnemySpawner
	spawner.spawn()
	print(len($Enemies.get_children()))
