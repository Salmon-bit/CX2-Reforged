extends StaticBody2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	var body = area.get_parent()
	
	if "mushroom" in body.name.to_lower() or "player" in body.name.to_lower():
		body.heal(50)
		$Area2D.queue_free()
		$Sprite2D.hide()
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play()


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
