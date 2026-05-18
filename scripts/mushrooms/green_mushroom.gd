extends BasicMushroom

@export var spawner: Node2D

func ranged_attack():
	var bm: BasicMushroom = spawner.spawn()
	bm.global_position = self.global_position
	bm.name = bm.name + "mushroom"
	get_tree().current_scene.get_node("Enemies").add_child(bm)
	attack_timer.start()
