extends StaticBody2D

var hp = 75
@export var mushrooms: Array[PackedScene]
@onready var spawner = $Spawner

func _process(_delta: float) -> void:
	if hp <= 0:
		queue_free()
	$Label.text = "HP: " + str(hp)

func _on_timer_timeout() -> void:
	spawner.object = mushrooms[randi_range(0, len(mushrooms) - 1)]
	var mushroom: CharacterBody2D = spawner.spawn()
	mushroom.global_position = self.global_position
	get_parent().add_child(mushroom)

func attack(damage_points):
	hp -= damage_points
