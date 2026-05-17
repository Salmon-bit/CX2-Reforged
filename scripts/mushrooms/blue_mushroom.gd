extends BasicMushroom

@export var projectile_speed = 550
@export var spawner: Node2D

func ranged_attack():
	var arrow: CharacterBody2D = spawner.spawn()

	var dir: Vector2
	dir = (player.global_position - global_position).normalized()

	arrow.rotation = dir.angle()
	arrow.velocity = dir * projectile_speed
	arrow.add_collision_exception_with(self)
	add_child(arrow)
	attack_timer.start()
