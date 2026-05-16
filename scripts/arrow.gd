extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "mushroom" in body.name.to_lower():
		body.attack(10)
		queue_free()
	elif body.name != "Player" and "arrow" not in body.name:
		queue_free()
