extends StaticBody2D

var is_player_in = false

func _ready() -> void:
	$CanvasLayer.hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_node_or_null("I_AM_PLAYER") != null:
		is_player_in = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.get_node_or_null("I_AM_PLAYER") != null:
		is_player_in = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_player_in:
		$CanvasLayer.show()

func _on_button_pressed() -> void:
	queue_free()
