extends StaticBody2D

var targets = []

func explode():
	$ExpoldeSprite.show()
	$Timer.start()
	for target in targets:
		target.attack(40)


func _on_explode_area_body_entered(body: Node2D) -> void:
	if not "arrow" in body.name.to_lower() and body is not StaticBody2D:
		targets.append(body)


func _on_explode_area_body_exited(body: Node2D) -> void:
	if not "arrow" in body.name.to_lower() and body is not StaticBody2D:
		targets.pop_at(targets.find(body))


func _on_timer_timeout() -> void:
	queue_free()


func _on_detonate_hitbox_area_entered(area: Area2D) -> void:
	print("Let me detonate " + area.get_parent().name)
	if "arrow" in area.get_parent().name.to_lower():
		explode()
