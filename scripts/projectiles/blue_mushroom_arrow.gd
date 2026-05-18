extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _ready():
	global_position = get_parent().global_position
	$Area2D.body_entered.connect(_on_area_2d_body_entered)
	$AnimatedSprite2D.play("default")

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if "player" in body.name.to_lower() or body.get_node_or_null("I_AM_BOX") != null:
		body.attack(get_parent().damage)
		queue_free()
	elif "mushroom" not in body.name.to_lower() and "arrow" not in body.name.to_lower():
		queue_free()

func _on_death_timer_timeout() -> void:
	queue_free()

func heal(x):
	pass
