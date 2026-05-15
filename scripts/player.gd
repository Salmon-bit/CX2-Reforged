extends CharacterBody2D

const SPEED = 20000.0

var bow: Node2D
var shoot_delay = 0.0
var arrow_speed = 600

func _ready() -> void:
	bow = $Bow

func _physics_process(delta: float) -> void:
	var direction_x := Input.get_axis("go_left", "go_right")
	var direction_y := Input.get_axis("go_up", "go_down")

	if direction_x:
		velocity.x = direction_x * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_y:
		velocity.y = direction_y * SPEED * delta
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

	# look_at() сразу выставляет нужный угол, без накопления
	bow.look_at(get_global_mouse_position())

	if Input.is_action_pressed("shoot"):
		shoot_delay -= delta
		if shoot_delay <= 0:
			var arrow: CharacterBody2D = $Spawner.spawn()
			arrow.add_collision_exception_with(self)

			# Направление — вектор от игрока к мыши
			var dir: Vector2 = (get_global_mouse_position() - global_position).normalized()

			arrow.rotation = dir.angle()
			arrow.velocity = dir * arrow_speed
			arrow.global_position = global_position + dir * 50.0

			# Добавляем в корень сцены, а не в игрока
			get_tree().root.add_child(arrow)

			shoot_delay = 0.15

	if Input.is_action_just_released("shoot"):
		shoot_delay = 0
