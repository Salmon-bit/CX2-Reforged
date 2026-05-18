extends CharacterBody2D

const SPEED = 20000.0

var bow: Node2D
var shoot_delay = 0.0
var arrow_speed = 600
var hp = 100

func _ready() -> void:
	bow = $Bow

func _process(_delta: float) -> void:
	$Label.text = "HP: " + str(hp)
	
	if hp > 100 and len(Input.get_connected_joypads()):
		Input.set_joy_light(0, Color(0, 255, 255))
	elif hp <= 0:
		get_tree().reload_current_scene()
	elif hp <= 20 and len(Input.get_connected_joypads()):
		Input.set_joy_light(0, Color(255, 0, 0))
	elif hp <= 50 and len(Input.get_connected_joypads()):
		Input.set_joy_light(0, Color(255, 255, 0))
	elif hp <= 100 and len(Input.get_connected_joypads()):
		Input.set_joy_light(0, Color(0, 255, 0))
	
	if Input.is_action_just_pressed("go_back_to_level_select"):
		get_tree().change_scene_to_file("res://scenes/ui/level_select.tscn")

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

	# Правый стик контроллера
	var stick := Vector2(
		Input.get_axis("bow_left", "bow_right"),
		Input.get_axis("bow_up", "bow_down")
	)

	var using_controller := stick.length() > 0.2  # deadzone
	
	if using_controller:
		bow.look_at(bow.global_position + stick)
	else:
		bow.look_at(get_global_mouse_position())

	if Input.is_action_pressed("shoot"):
		shoot_delay -= delta
		if shoot_delay <= 0:
			var arrow: CharacterBody2D = $Spawner.spawn()

			var dir: Vector2
			if using_controller:
				dir = stick.normalized()
			else:
				dir = (get_global_mouse_position() - global_position).normalized()

			arrow.global_position = global_position + dir * 50.0
			arrow.rotation = dir.angle()
			arrow.velocity = dir * arrow_speed
			arrow.add_collision_exception_with(self)
			get_tree().current_scene.add_child(arrow)
			$ShootSound.play()
			shoot_delay = 0.15

	if Input.is_action_just_released("shoot"):
		shoot_delay = 0

func heal(heal_points: int):
	hp += heal_points

func attack(damage_points: int):
	hp -= damage_points

func _on_back_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/level_select.tscn")
