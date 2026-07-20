extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var can_use_ability: bool = true

func _process(_delta):
	update_texture()

func update_texture():
	if get_parent().dead:
		return
	var ab = Autoload.data.ability
	if ab == 1.0 and can_use_ability:
		sprite.animation = "golden"
	elif ab == 2.0 and can_use_ability:
		sprite.animation = "through"
	else:
		sprite.animation = "default"
