extends StaticBody2D

var targets = []
var is_exploding = false
var tnts = []

func explode():
	if not is_exploding:
		is_exploding = true
		$ExpoldeSprite.show()
		$Timer.start()
		for target: Node2D in targets:
			if target.get_node_or_null("I_AM_TNT"):
				tnts.append(target) # Delayed explode
			else:
				target.attack(40)


func _on_explode_area_body_entered(body: Node2D) -> void:
	if\
	(body.get_node_or_null("I_AM_MUSHROOM_ARROW") == null and body.get_node_or_null("I_AM_ARROW") == null)\
	and\
	(body is not StaticBody2D or body.get_node_or_null("I_AM_TNT") != null):
			targets.append(body)


func _on_explode_area_body_exited(body: Node2D) -> void:
	if\
	(body.get_node_or_null("I_AM_MUSHROOM_ARROW") == null and body.get_node_or_null("I_AM_ARROW") == null)\
	and\
	(body is not StaticBody2D or body.get_node_or_null("I_AM_TNT") != null):
		targets.pop_at(targets.find(body))


func _on_timer_timeout() -> void:
	for i in tnts:
		if i != null:
			i.explode()
	queue_free()

func attack(_i: int):
	explode()

func _on_detonate_hitbox_area_entered(area: Area2D) -> void:
	print("[TNT]: Trying detonate by " + area.get_parent().name)
	if "arrow" in area.get_parent().name.to_lower():
		is_exploding = false
		explode()
