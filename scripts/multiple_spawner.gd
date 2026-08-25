extends Node2D

@export var objects: Array[PackedScene]
@export var objects_chances: Array[int]

func spawn() -> void:
	var i = randi_range(1, 100)
	
	var merged_objects = []
	
	for n in range(len(objects)):
		merged_objects.append([objects_chances[n], objects[n]])
	
	merged_objects.sort()

	var spawnling = StaticBody2D
	for mo in merged_objects:
		if i <= mo[0]:
			spawnling = mo[1].instantiate()
			break
		else:
			spawnling = objects[randi_range(0, 2)].instantiate()
	
	spawnling.position.x = get_parent().position.x
	spawnling.position.y = get_parent().position.y
	
	get_parent().get_parent().get_parent().add_child(spawnling)
