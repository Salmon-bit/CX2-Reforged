extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if\
	body.get_node_or_null("I_AM_BOX") != null or\
	body.get_node_or_null("I_AM_MUSHROOM") != null:
		body.attack(100)
		queue_free()
	elif body.name != "Player" and "arrow" not in body.name:
		queue_free()
